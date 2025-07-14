Return-Path: <linux-kernel+bounces-729262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C73B03400
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778B71666DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C025189F43;
	Mon, 14 Jul 2025 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLiXd8+L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA01CD0C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454606; cv=none; b=CRhd/CAUIqXAY3z5jetRcVG8NrpLQ64eqzraAdbfVw/kXJWoXyeeuu7A1epPwR0RSj9CzlJrwDd3cjwEFSL8fo4DFIfFPfNulZNtfEmrwl63zh7TkFoUCWHg/6JhLUEpI4f2S3+kpQWdMQD1iUwY3aIp4JUZvlT08aqBfefgc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454606; c=relaxed/simple;
	bh=Aj2wrqzNkDFUp0Qlcm9ZHkXFqT0KNjoQwLntUrA8h4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N53Zk8bP9r6P63VY1pD/GkS37wbBbRV5LZ23mawR4ctwQWU+czcIBC9Fyr4I70B96Dd0E6uQI/j1DoRAn14n0OIoF6dIsFJaQ6uSMARgxXRPPFnYDo9KQfC2qKpEGRS3SSyJFXxSmrDwZrxM19YesqdlNQ51wd+l5jDtKN3BMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLiXd8+L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752454602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qUmVGWmiQ9qj6UDI8yyGeFapyi86on9NnjOakrMOqpk=;
	b=bLiXd8+LtLU0OzbdzO/ANH6EO6G5V8QjtSjGPcap0esMuzMg0g5aNpliz5T3ZRs4gRbk3S
	WRgDZx4///LPkIRUyiKbSBV95tKjNStKsV9KeUJPBUoUn6xyEa7xHjlVbRFp8bG6PUGdF4
	eMLrrEVf3VZpy9svJSrWy0/Rgiar+7s=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-9xRW2Ud_P6ysE9jhP4q1VQ-1; Sun, 13 Jul 2025 20:56:41 -0400
X-MC-Unique: 9xRW2Ud_P6ysE9jhP4q1VQ-1
X-Mimecast-MFC-AGG-ID: 9xRW2Ud_P6ysE9jhP4q1VQ_1752454600
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b362d101243so3110045a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 17:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454600; x=1753059400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUmVGWmiQ9qj6UDI8yyGeFapyi86on9NnjOakrMOqpk=;
        b=g/lmZ/9xo3SmSQTfY8eJDU8/AuPpICCBwS64wdTGSIUZAsxA6DP82O5hsD0iVDw9bB
         k4wFAtP2mU1Cjonpn8NMA4OmL/wTogp8/OJT3oRYo9utfcatvp8uuhzv6MSzN0p+5kMI
         IJHTDtw5T0Dsp3OSZGgzndWb/vfPjbab7CR3g8SrOS/OVBisxukYJDyqFV3/h9VWimK5
         8wpkAvp/akChEpcFkTOZypsgi2yBHqIY3zdqHPM0tFEL0oEnSfnQFIrGc1bv+yCDMdcn
         DpAQ+wHo15mVezq8ObC0Unw/OTenwFbRED5Hy2QrhirUJhZKjM6UYI7ZFtRlNueU9dn6
         k2QA==
X-Forwarded-Encrypted: i=1; AJvYcCWtHx16yS2H8jfwgDwES9teI/HlDVi7BxiNPru7AibVNHdv1CsAD+Qycbf/o+0SAS2VRH0nEYtClBcpCNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgotfKP2x2PxPLkLc9dI42NJnqW8PzAViW7vxYHlLtGArrRemb
	7O06MfXcRlrALxWosI7n1eOs/dNXn5kKPge4MXSeizmEBmIk7Q//S/W9bnAW1Ikzk4WEggQOcHQ
	Jz/sv8UuSSB+FiyJ21AD5X9h1tyAKHPgmjzGTkrm6oAiWnGms8Xh3bWUvlJA0ud/eRQ==
X-Gm-Gg: ASbGncui7yJTwM1gCntmfZNo47+O486NBSAtSbU6nFmo0WA5v3CrSZzor3G1/sKphN8
	svl3cd681A06d76jddUoViD0NW2m1ok/AfvMQeslBzJFkRAffnJMCsKYCX8fYVQTJdJ2Y2toavW
	hGNJA1oKYhiJVnhxRLOWsOr9M5ENSACbwdUTa2RdERVG4DkJf0MOXv+4FW6GEDr6mzuyNCSSqeV
	6cR/o3VIP9qTKF/nlrvXZTv87ggVMPyFU97gPHg+75NGnOSD/O5VwvfC7awruc74zQxIwQzQm6i
	Hz2DSZofA9PiOY0QdCF8nplAo+A7RtnA0VtMVRaPRA1P97iaw0QHhYL9XL0SjIHDi2MROKQPV4h
	RUgQ=
X-Received: by 2002:a05:6a20:a108:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-2313504eae8mr16343983637.10.1752454599958;
        Sun, 13 Jul 2025 17:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuM+Zi92A0hbUgn10WrjgmwNif+FKdGvokkBLHmwp/rW6/7cd0fjnuie824/YWyiFVdE8dUA==
X-Received: by 2002:a05:6a20:a108:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-2313504eae8mr16343960637.10.1752454599481;
        Sun, 13 Jul 2025 17:56:39 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe727e33sm9168382a12.68.2025.07.13.17.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 17:56:38 -0700 (PDT)
Message-ID: <05605650-2dd2-4abf-b0a5-f727753db7f5@redhat.com>
Date: Mon, 14 Jul 2025 10:56:28 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 (RESEND) 00/20] Change ghes to use HEST-based offsets
 and add support for error inject
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 linux-kernel@vger.kernel.org
References: <cover.1749741085.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <cover.1749741085.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mauro,

On 6/13/25 1:17 AM, Mauro Carvalho Chehab wrote:
> Hi Michael,
> 
> This is v10 of the patch series, rebased to apply after release
> 10.0. The only difference against v9 is a minor confict resolution.
> 
> I sent already the patch with conflicts, but, as you didn't pick,
> I'm assuming you're opting to see the entire series again, as it
> could make easier for you to use b4 or some other script you may
> use to pick patches. So, let me resend the entire series.
> 
> It is nearly identical to v9 which addressed 3 issues:
> 
> - backward compatibility logic moved to version 10.0;
> - fixed a compilation issue with target/arm/kvm.c (probably
>    caused by some rebase - funny enough, incremental
>    compilation was fine here);
> - added two missing SPDX comments.
> 
> As ghes_record_cper_errors() was written since the beginning
> to be public and used by ghes-cper.c. It ended being meged
> earlier because the error-injection series become too big,
> so it was decided last year to split in two to make easier for
> reviewers and maintainers to discuss.
> 
> This series change the way HEST table offsets are calculated,
> making them identical to what an OSPM would do and allowing
> multiple HEST entries without causing migration issues. It open
> space to add HEST support for non-arm architectures, as now
> the number and type of HEST notification entries are not
> hardcoded at ghes.c. Instead, they're passed as a parameter
> from the arch-dependent init code.
> 
> With such issue addressed, it adds a new notification type and
> add support to inject errors via a Python script. The script
> itself is at the final patch.
> 
> ---
> 
> v10:
> - rebased on the top of current upstream:
>    d9ce74873a6a ("Merge tag 'pull-vfio-20250611' of https://github.com/legoater/qemu into staging")
> - solved a minor conflict
> 

[...]

Just head up to check if this series has been merged? I don't see those patches
show up in the latest upstream QEMU yet. The reason why I'm asking is the subsequent
fix [1], which depends on this series.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg06433.html

Thanks,
Gavin



