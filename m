Return-Path: <linux-kernel+bounces-885359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D338C32AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6EF188BD10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B833343E;
	Tue,  4 Nov 2025 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HBIDbtxO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F93D275AE4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281388; cv=none; b=nupgmsz8sR9asH78wZbVn3kZUQT6uIbbe+F+mQu7RZMuwyQyFJUIxefkzldirKJBe+WUa2LKVZaXB26hSMGyxfMwwKFCDLVQIxO8oHakI/mWj8idE8QSzweyYQuifSwGLemoA56F5risAGiwaxCWWhvJsWH2PcJ9VqZUagNvxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281388; c=relaxed/simple;
	bh=AuWLO47Op0A6cXiQCT3lnMl7si4MV471QvuioS+vdqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TicCrdlaw3pn+GA9K2XExziQg9bpfiIPpd6M6Rmsonx6a0nDT+89rN+DE1rRrR0LphMP2PKALy2AykYNHNSmKejFfZzPAUxodTHnffWaFatDM1jcZSFUH1fYjF7HuAu1dOhIGwRV7vzn+Yp1NajIuomRrd/SEgDEBAjkIg5jz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HBIDbtxO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47721743fd0so31769935e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762281385; x=1762886185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+qOQwxfN64qmYsF01vjK7YlVT/sIFKRQ4EeU3BDs4o=;
        b=HBIDbtxOjeulc/p1M3/WFPuBqjchvgQInrCIfAsgoj5z1ohWS82RZakjTs+ALxzi3o
         JLmFrGy8gKL11o83DdyhVRu4eGhlkH0VKUSWNTREa06MHDpDfjLn0W9Tda6ggZMghoVm
         19HOhz14KjtvN89IvD+Uj5nMZEzRECPBQ3dQ6RTOc0SkWuoxWWIMYdejQRNyorsNfUqL
         yN1qVSdWevyLqgZQ+o47o+oe+ljQ6Kal2UJBaVJrbwxyc8+RXKtcIzLociyaVjLkD8RJ
         pKgthmlQVlnbja+wGI8woQoI9eO5rro2kPeLeQTexcVr93n2IngoT5j9mb0Z1Kfdor/e
         XO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762281385; x=1762886185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+qOQwxfN64qmYsF01vjK7YlVT/sIFKRQ4EeU3BDs4o=;
        b=KDU4dCLrJ6CZ1kxS64MAR/KxW0vLXKkLvxV/rJpqM4lRbD+dogfAg9pzhMJGiHS2xa
         IboyxFBn058nhbDRaQokwUqM3BdfHHQ9DiBfhQhQGSTwk+f23NyoMwkKBAAlfviTjT+N
         u/ejejJzlkkOJKxk3SoGgXfxHeG/RdZbe45N4duER2IDezOeYwEDglWSY+042pfNIrvf
         m/lXMkQrX9gnvxmvl9EOjbXV4UXCzXiUtI6uPqYmPLjwzCI9KjlF0CraKZa1fGneenH1
         LgY7eimPm3uWRzcaqup7uWJi5blR+5ig90Sopk3zctlbbMiYK6et9PqyP87tT0h1wAYl
         uCew==
X-Forwarded-Encrypted: i=1; AJvYcCX+q729aobyRrBQCnO+szD0QAyTipVuyirhvlhISLC/uqWLeBEjkQeGAI03+Vt0I14amcsJsfQ7+0iPZOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1j7WV1lPKzPrikhJttVFZPcgFUEeKCPf60jPj/SXUPzO9n+A
	3uRAq9TxEOui93gVOaPlS3eFt9/Nag1Bik5KCjos4V6DrplcpCALwCFssBdYOfBq6cc=
X-Gm-Gg: ASbGncul0ovjwU1z95o5fW+Qh+zdcR8cmrVO3Jg+LUsX+76xctRtv0xo+VFFoCPGIWv
	AtJjitEbCJpx5jud7UNoW5+RcJ1PObu7CnuRt7rKp0ryT4Jium61w5ubiHSZP8WbvO8qPts2C/b
	Lrft2KQAJXmJ8IN2teLDLQNPuMTmXMlelK4d64zip0ScYvtbBgeZQOfn2KY7ahLpfVrYepp85Ny
	4lCl65lQG/hoKI0pFSweakXMixbm4lc/rgpZI1+HdEsB9f9KIqTD1Dl4Lk1cC6b1jEsNIgLY/gW
	yjp24ooBUum+G6ZyQO8W0jDNr6zWyDOiY3tMcTxPIPOziuXRDcgrBiWD+wFLfJuh3c9r00UUVaP
	CokdHgitRnqT5rW463Qf+iAcePE3RGrdrOd+CT6BBZD4X8EqYpHMC9pf4W/8uvfcTfdtG4w8fje
	hafOePhugFgfmi7ALt7k7lpbA=
X-Google-Smtp-Source: AGHT+IEnR2psnzPx+1g8M1v8iuPpltBNgHmLBznqDt6V+MFNoJ7oCyKOUDMVl+6Ny1hv8tF/qNLwHw==
X-Received: by 2002:a05:600c:1d07:b0:471:803:6a26 with SMTP id 5b1f17b1804b1-4775ce265d1mr2708915e9.37.1762281384874;
        Tue, 04 Nov 2025 10:36:24 -0800 (PST)
Received: from [192.168.15.14] ([152.234.106.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd392040csm3651030b3a.19.2025.11.04.10.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 10:36:24 -0800 (PST)
Message-ID: <33de0eaf-474b-4e88-a445-2f12387bc36c@suse.com>
Date: Tue, 4 Nov 2025 15:34:12 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: client: fix refcount leak in smb2_set_path_attr
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Paulo Alcantara <pc@manguebit.org>,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
 Bharath SM <bharathsm@microsoft.com>
References: <aQoYCxKqMHwH4sOK@osx.local>
 <CAH2r5mu7s4p88RhUbCm5mqUvEVM60OOTTJOZ+rz09nFfc+t3mQ@mail.gmail.com>
 <648b7b14-d285-449a-a1b3-4cd062a55b02@suse.com> <aQowQ7gCdDruGVro@chcpu18>
Content-Language: en-US
From: Henrique Carvalho <henrique.carvalho@suse.com>
In-Reply-To: <aQowQ7gCdDruGVro@chcpu18>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/4/25 1:56 PM, Shuhao Fu wrote:
> On Tue, Nov 04, 2025 at 01:23:33PM -0300, Henrique Carvalho wrote:
>>
>>
>> On 11/4/25 1:12 PM, Steve French via samba-technical wrote:
>>> There are multiple callers - are there callers that don't call
>>> "set_writeable_path()" ?    And so could cause the reverse refcount
>>> issue?
>>
>> Yes... Even if it does not cause an issue today, that fix looks like it
>> belongs inside smb2_rename_path?
> 
> I placed decrement in `smb2_set_path_attr` since it seems like a wrapper
> of `smb2_compound_op`. I figured that this wrapper should handle the
> failure cases the same way as `smb2_compound_op`.

Makes sense.

Acked-by: Henrique Carvalho <henrique.carvalho@suse.com>

> 
> Thanks,
> Shuhao
>>
>>>
>>> On Tue, Nov 4, 2025 at 9:21 AM Shuhao Fu <sfual@cse.ust.hk> wrote:
>>>>
>>>> Fix refcount leak in `smb2_set_path_attr` when path conversion fails.
>>>>
>>>> Function `cifs_get_writable_path` returns `cfile` with its reference
>>>> counter `cfile->count` increased on success. Function `smb2_compound_op`
>>>> would decrease the reference counter for `cfile`, as stated in its
>>>> comment. By calling `smb2_rename_path`, the reference counter of `cfile`
>>>> would leak if `cifs_convert_path_to_utf16` fails in `smb2_set_path_attr`.
>>>>
>>>> Fixes: 8de9e86c67ba ("cifs: create a helper to find a writeable handle by path name")
>>>> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
>>>> ---
>>>>  fs/smb/client/smb2inode.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
>>>> index 09e3fc81d..69cb81fa0 100644
>>>> --- a/fs/smb/client/smb2inode.c
>>>> +++ b/fs/smb/client/smb2inode.c
>>>> @@ -1294,6 +1294,8 @@ static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
>>>>         smb2_to_name = cifs_convert_path_to_utf16(to_name, cifs_sb);
>>>>         if (smb2_to_name == NULL) {
>>>>                 rc = -ENOMEM;
>>>> +               if (cfile)
>>>> +                       cifsFileInfo_put(cfile);
>>>>                 goto smb2_rename_path;
>>>>         }
>>>>         in_iov.iov_base = smb2_to_name;
>>>> --
>>>> 2.39.5 (Apple Git-154)
>>>>
>>>>
>>>
>>>
>>
>> -- 
>> Henrique
>> SUSE Labs

-- 
Henrique
SUSE Labs

