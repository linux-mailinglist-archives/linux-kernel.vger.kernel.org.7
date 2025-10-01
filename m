Return-Path: <linux-kernel+bounces-839289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F1BBB141A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAC63B017E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2328003A;
	Wed,  1 Oct 2025 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="ft1os/zS"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9BE1F3BAC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336461; cv=none; b=Wy016Xq4hiKvtMOY0SRHCgsuDseMf0/+sxzDoOYSzL3CilT4MkTXfW/clOMjrgh60LB6Ips9B+8ehPFAZRC3v1Gkz4AWJ8Z9uqS8A6cGq7JE+AFuDq60TEJqhrgsJ3IxZcBaEsx+GUlO4DAylSZfpTwkFQZaOj4mmx0/odXOVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336461; c=relaxed/simple;
	bh=5+QqJQbHRRoYFJP7mLVXHvJ98veWuboSrwuUjqJ3OeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6GclbTPCaAryKPay6fyBzr9nSA5rdKtq214np806BIWUOH2KQzAlxqfRiFA0u0oEBYELvR2jEWRd/EDTqdaQE2TaJv8c7M+nqbHXMDYiKGnnCDjeWG4ohJ8Ew9VhCZ+M6ieal5wjoEYspdNiDkr98zKwsYacFGhuMOV7tcXOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=ft1os/zS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-85d5cd6fe9fso5647985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1759336459; x=1759941259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3OHJw2rFgayx5kHjxMIlmwKKQXiU3P7o73X7At+/J4=;
        b=ft1os/zSVeWo0HiNfP5vDQdzNygkx0kXKHoZJ6yzierkACmWZOxkpngrMrje4Mb36G
         nwjCzgYoWgnTWUuP2wczGu1UBbb5ygeVzTs7YfyIJTzX4th9H3BLTb8ymv2XkxVY0f1t
         OF3k7yGGLKET/ILpBvp//p7ewhWuAUYAg4jVpVbFB63d639Fs9blnyrd9/Sfg+MBxl3k
         XdsCmGCY46oW3O3wC3raxY0Jf2ULdZXBBxlZdgddDdFavlLN51H9KjGMVaAcQzlg9lBK
         uStbgnUejY5lVkPTsKN7almug4DAx3Buu64r9ZIjEAVxSHCLzZCv/88ck/E5IGZQF/o6
         tm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759336459; x=1759941259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3OHJw2rFgayx5kHjxMIlmwKKQXiU3P7o73X7At+/J4=;
        b=davVrGeN7oBgY1rp76Ecgf5ryD51UZUopUcfJzmPYCAYNB//5gBO5R1+3sA/rwZEL+
         4IXuYMQ94WbNJBqldlG9ODQxIMWT9bY/NSIiGFcH8UvUI8GRgRyNMeREYoYiy8HJo5hI
         Ti8MfGxauNFcna4iMPdkggGRTLF9ogoOV12xdtNpMBdXYP0T4BGNupbdWNwxulau/1CC
         ob6XBkQX/fTe0k4fWzcK0rVEui3eL8975mRQtgGnzIZDmPPoh/sKTpG62AWNm0pRU5MX
         56gUgOOLUnUaLiyHsfZwvbx7XHWsEWRGiVJigg/zTfRhuBr9LKNXaqZwmWVJqXs6I5fp
         +yRA==
X-Forwarded-Encrypted: i=1; AJvYcCW3z2zFvuPcaW3uGFt8Pd8nKu9JLpXGRwOZHyUSTyzOTOzlgfEAM20lO9fpzdGiM/N0W98KT2BMdVK3ghU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVk0M6lTEVJbMKizIdUqrp+I8u83/7Y1h+lD0jiK+OZBWHOxQR
	70L6oLSh0qQQM7e3eDUua2RiVx+DkokX/7/U+1gi0ZMd2q0tVwg1DAmGGYx/vny4YHXVVktaJQ6
	gOp0a
X-Gm-Gg: ASbGncuAo7Ej/YMj0cW67Gt1kL0xbG2fNkVacs+OqMqwrgEYSwmDWZYXtiIIJQeJ3ff
	74op/5IIUJJMxK9CXMk/kONKUSz+BsA8IDQ8+l7gXopGtrajh3WJD8Rerb8P1AcLN8U/vAjNa7i
	oqkPTEQfreZwQ2XyS44c0zJ6/P/svTsw7y2piw+Fe71jeitx5nOy7/zoSJCxQUUZHqIS3Vb4n2b
	LUGTexWW61NDFE5FQxGsb7HrTGpSh8tMmq3aSCETXH4EEEqIadhm6sQO5CU3GXca7Fg8FV63Aj1
	VKHbejw8QonEU5u3+I2sOCr3mKQB3j6FUXL6rJUMKk+1VdL0bCVrH3C4E/PeBLxnSIDO1/jMa1U
	DWcZG0mM7XuDOJO3oZ2U/+7mUMtSQXPDDLVg88M7e8MjaykXuw/Jsojbb8fg=
X-Google-Smtp-Source: AGHT+IG7mfdSIVF3b6xWViAv4VKI/WY1cdPmIB6tNLMxyt7NIxTMEwyV5GEywZ7bf4CfOh0oMEVWFQ==
X-Received: by 2002:a05:620a:4505:b0:870:4652:4d19 with SMTP id af79cd13be357-873720c1d59mr598377085a.28.1759336459079;
        Wed, 01 Oct 2025 09:34:19 -0700 (PDT)
Received: from [172.24.25.128] ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772836c1csm8359185a.28.2025.10.01.09.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:34:18 -0700 (PDT)
Message-ID: <408ad037-639a-4051-831b-b663c0d2d772@zetier.com>
Date: Wed, 1 Oct 2025 12:34:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cpgs@samsung.com" <cpgs@samsung.com>,
 "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
References: <20250912032619.9846-1-ethan.ferguson@zetier.com>
 <20250912032619.9846-2-ethan.ferguson@zetier.com>
 <PUZPR04MB6316E73EE47154A64F8733DA8118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Ethan Ferguson <ethan.ferguson@zetier.com>
In-Reply-To: <PUZPR04MB6316E73EE47154A64F8733DA8118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/25 06:28, Yuezhang.Mo@sony.com wrote:
> On Fri, Sep 12, 2025 11:26 Ethan Ferguson <ethan.ferguson@zetier.com> wrote:
>> +int exfat_read_volume_label(struct super_block *sb, struct exfat_uni_name *label_out)
>> +{
>> +       int ret, i;
>> +       struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +       struct exfat_entry_set_cache es;
>> +       struct exfat_dentry *ep;
>> +
>> +       mutex_lock(&sbi->s_lock);
>> +
>> +       memset(label_out, 0, sizeof(*label_out));
>> +       ret = exfat_get_volume_label_dentry(sb, &es);
>> +       if (ret < 0) {
>> +               /*
>> +                * ENOENT signifies that a volume label dentry doesn't exist
>> +                * We will treat this as an empty volume label and not fail.
>> +                */
>> +               if (ret == -ENOENT)
>> +                       ret = 0;
>> +
>> +               goto unlock;
>> +       }
>> +
>> +       ep = exfat_get_dentry_cached(&es, 0);
>> +       label_out->name_len = ep->dentry.volume_label.char_count;
>> +       if (label_out->name_len > EXFAT_VOLUME_LABEL_LEN) {
>> +               ret = -EIO;
>> +               goto unlock;
>> +       }
>> +
>> +       for (i = 0; i < label_out->name_len; i++)
>> +               label_out->name[i] = le16_to_cpu(ep->dentry.volume_label.volume_label[i]);
>> +
>> +unlock:
>> +       mutex_unlock(&sbi->s_lock);
>> +       return ret;
>> +}
> 
> Hi Ethan Ferguson,
> 
> This function has a buffer leak due to a missed call to
> exfat_put_dentry_set(). Please fix it.
> 
> Thanks
Apologies that I missed that, I would be more than happy to submit a fixed patch for this,
but I checked the dev branch of the exfat tree and noticed some lines were added to fix this
problem in my commit. If true, this is fine by me, and I will sign off on it, but I just
want to make sure that's true, because if so then I don't think another patch by me is needed.

Thank you!

