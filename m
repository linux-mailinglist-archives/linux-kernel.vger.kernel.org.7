Return-Path: <linux-kernel+bounces-762063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA3B201C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714B7173356
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804E2DAFBB;
	Mon, 11 Aug 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAFVw4tr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44111E2307
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900713; cv=none; b=GlTmy82jy4O2vpyr7mxk2h9scX39J/4qiGJeq+vGlPS830gVAdKKYRECjaU9D11tJiC8DwVCiYac3IDfl+HtZK44ropTefIO9Qu0R8utRCZNoxK3TMXZuUvHHN+4KYBzI9Qax/sJA+AGELaxdLfOKx1FX1x1V+VGbF44hZf4rGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900713; c=relaxed/simple;
	bh=J6zF7y75O/oD8aPIloTQuFggdm3885HLRZTTt5DlRmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcaqOcoe+AYl/XS1OlfwnSaEH6Pp626R2xObos2fltZ2DlnOrIf2cT9pvayjdH43a/XY0Mu83RnfYAjyOG271ettlQAnjOhKqBK2YQipBwy8MtR3i0WsEvlS4LpBiN04lbBuuRd+eAtFa1fNTaZAnLIepcKihP6oKSdjIzoFYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAFVw4tr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754900708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n6C9X31/Hy+tBgbHhW3cXx2Ui62iF3UNJy/wooh4xnM=;
	b=SAFVw4tremqau3qFXc0NF6sdo3ZJszt3VOM6c4Z4/klZhu5sp1xG1vo0Ds6Blxc0Ue+ctG
	n2nT27M8IR1GYser1sAlvX6hV5smKk0huNYbMssoCoKSmSGNsnF31JsG5mtL49mvSgsDkp
	fTzIYYAePGBqga8xMQbo/jrjKRKkmoo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-95I5OI2xNtyQ0-Gc9wxyNg-1; Mon, 11 Aug 2025 04:25:06 -0400
X-MC-Unique: 95I5OI2xNtyQ0-Gc9wxyNg-1
X-Mimecast-MFC-AGG-ID: 95I5OI2xNtyQ0-Gc9wxyNg_1754900705
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so21193445e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754900705; x=1755505505;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n6C9X31/Hy+tBgbHhW3cXx2Ui62iF3UNJy/wooh4xnM=;
        b=XceY0M1Y3/CavelktEXCybB3X4ETFtpyJlhvzqzxA1KzHDm3aAFxquU/+DScgP3nd3
         WtmzR0pyBDqvWFgOi/5z4V9uk5ALMEZp7e5vE1NxTWPpL4yS+ZAR+o7i/WuSKf6OXmha
         mWwQMlucHEOrxx200x2cv3JTXCw+fNff5YZ9RymOL49zovuvmkV4eKioTGa3ggxpZTYZ
         44sShS7oFaJdaMg+dM4OoaiDOrRZuRnDGarj4KxPx2hhAEHyLv5efGzraG6vaG50z6r3
         H+19wpq0OIEq599H+U7CH7fSG1jySRTt0X2VBHy4WvjWQ1mhXD+CDF3CDaeBCZ2e3S7X
         i2YQ==
X-Gm-Message-State: AOJu0YxiZMvof1p11HVXGJFY2crskCxE8lfsvAANZQO6TlXc9ERQg8Po
	R4RaMr68h+E3BdZwipl5f/tSrEbIhvGIe75XA0rLgjJvM0HOEYx9xs1PbPYZFCvbAn3PuScH340
	MOWCV3kKUOMugIfs3gha3wsJFH4qMucfJxae6UaEe+wOQe1iv8mDvT07jU1xpB0cADA==
X-Gm-Gg: ASbGncvPZzRw3beCsMVmmEU6gYZbordEKT9wDALA2kkAv9F1kohNu6yIPGdDp1fwg5x
	VtcvilSA4s+E8jIVZnRzjEMRl9yA8dJSBD80V8pSg+cCEnYYQE9MQVk/cH/3Z9AsZ1jqyOIGlom
	oHqylSrdjTATXi19EDC/RFieHEf3hNpPORCbFKVTd2B70yl6hwdnqLyT5PIvrk3aE0+ckxOVuVN
	Q3BrhbP0TkQ0hooISEnPpaHFmaDTL+IfY8sfepgsUcnvJ1kPGL2FkF4mHZimR79cjXaWEV2T1RS
	lbtsoKZKfSQDX4S5NUTHp8w3qZLtUweZ7dsIHvUD5wFyea3UKLuWS6wzwy2ctFBuIUcTLTW0nD9
	9M9qGEKGYjYfZX4IOknTUmvgArr4KmBpIG//Fzmq9No2DFALfXKtavRvIAyqJoizwhNo=
X-Received: by 2002:a05:600c:4fc5:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-459f4fafcccmr94005765e9.25.1754900705405;
        Mon, 11 Aug 2025 01:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFydH1lC76H3QE18kdorihcpkKlLneA+rnw3oe62dpzyYtfZUXDgVzMZXii96GyI35IFYH2Vw==
X-Received: by 2002:a05:600c:4fc5:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-459f4fafcccmr94005435e9.25.1754900705010;
        Mon, 11 Aug 2025 01:25:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac574sm39685760f8f.5.2025.08.11.01.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:25:04 -0700 (PDT)
Message-ID: <f358f3ce-1140-4dd1-a1b8-379563c5f050@redhat.com>
Date: Mon, 11 Aug 2025 10:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org,
 davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org,
 ryan.roberts@arm.com, osalvador@suse.de
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
 <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
 <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
 <b5b75976c94b7b46f86a5af4675a1a570aaf20cc.camel@physik.fu-berlin.de>
 <2bcb018c8b237f7ab2356f4459e14ae81a6fec8b.camel@physik.fu-berlin.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <2bcb018c8b237f7ab2356f4459e14ae81a6fec8b.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 00:20, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Sun, 2025-08-10 at 11:52 +0200, John Paul Adrian Glaubitz wrote:
>> On Sat, 2025-08-09 at 08:42 +0200, John Paul Adrian Glaubitz wrote:
>>> Let me know if you have more suggestions to test. I can also provide you with full
>>> access to this Netra 240 if you send me your public SSH key in a private mail.
>>
>> I have narrowed it down to a regression between v6.3 and v6.4 now.
>>
>> The bug can be reproduced with the sparc64_defconfig on a Sun Netra 240 by setting
>> CONFIG_TRANSPARENT_HUGEPAGE=y and CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y. When testing
>> on a modern systemd-based distribution, it's also necessary to enable CGroup support
>> as well as enable support for Sun partition tables with CONFIG_SUN_PARTITION=y.
>>
>> Then it should be a matter of bisecting the commits between v6.3 and v6.4.
>>
>> I will do that within the next days as I'm currently a bit busy with other stuff.
> 
> OK, it turns out it's reproducible on older kernels (but not as old as 4.19) as well.
> It's just much harder to trigger. I found a reproducer though and will try to find
> the problematic commit next.

ext4 support for large folios was added recently (6.16? not 100% sure).

But below can indicate some ext4 issue with large folios. 
(fault:filemap_fault mmap:ext4_file_mmap)

-- 
Cheers,

David / dhildenb


