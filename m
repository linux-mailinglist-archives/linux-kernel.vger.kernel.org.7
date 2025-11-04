Return-Path: <linux-kernel+bounces-885123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C32C320CB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1703BE26B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4C6331A49;
	Tue,  4 Nov 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DE5KIayB"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D92248BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273550; cv=none; b=N1qcBQxK07rNghWkERaN0OmDGuoHcdxjQ2IHt4TbCYtWmel5n8KrSb7z5vkEjL0RiX0cwSIyidxojEBQPn2iUHGLkD68zIpLBiuynyTMVgm02d9B+wEA9jIRiSgzRwB3vYK5gFni+RZZHCm1jxLW7ZyNRrrsUunYSqMLQYMrI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273550; c=relaxed/simple;
	bh=qtUlZPIvwB/gYjNgToSLBp2+/9TzzxHQwlQvLSmCuas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1KS4tYWwpsco4ueo3KJsLMAcQSpd4FBNa5IcTGmHdYYqDwHRZtezz8PLoyilSzX/vCbd5EhcS7NOW+6xChsQE9MplrkFCXlMzmrJdch0uNiKP5tb69EZaSPghGVdnlz5TN6ZdBavMGW004W5SIRlNV32gaupjdim/YhQ3UyKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DE5KIayB; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4298b865f84so2740179f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762273546; x=1762878346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVEicm+5HOPZi8EXNv//e7Ln/RMba4QPS1zib01aWog=;
        b=DE5KIayBW5I5oJxy7IFkVMtf7QUBgIhSLZlCmFY3J4P3gjvqtoemuqomAcOAAqXuFm
         KZewJtClhFAMzPmRD76GGJFerbdSDvV3PhnTz3g4t8NYim1c4jrHSSA34XG63Higikwn
         H5OFVCGxL3rFI3qxUOgiI5jX+RcPCJ8hFhJgjOYmtUKpXbV71gktgK1lxGV6g/tw0ORz
         R7u5RN+9H2MOU9yPluqX74QT6p1FJQWnvy9J7aAJiKrZjhuQF95Df1Y9C5Hq86GOKxXm
         19NYk9W7ExALV5bFTeBVAPhCVkVcjKR/YacrNN9Em6pwdwLOPfp332RkBOX8WMs+izx/
         pDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273546; x=1762878346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVEicm+5HOPZi8EXNv//e7Ln/RMba4QPS1zib01aWog=;
        b=Z8AB1t/gdwBYC2g6K9dkso+H0jesSnFKyUuzg11sOWuICQWSIPx5rtbBOitl8wVufu
         jMNQYLagmztWim7aASkDSFGRx0ptoZrx1HYtoCyPv1wewYfJDc1X9sSbqVE4kpOW7m05
         pmoNnZ6G5BgiDYQ0gaF5zqO9Lv3m0TxSAESAg1EhqIugiuYrBxkgdEdCSdK+IYVSBKUi
         LqmciUGgUQooO2k9FMaoiGIQpWyqGlpvmzDW6ho//FuJXXDUlvm3Plj5uFrfqg6ypTL8
         WLbhlyDBbMZF7aBsQ01g9hpPBz4j6z2K6iDZsBn4J1SsmM0+UNlq01H32qP2OLbOIzaG
         Qkjg==
X-Forwarded-Encrypted: i=1; AJvYcCVNXIVFGUOEwzM0lbxQl36LveYl38QFGRqPusQZGWioY8fddOqGtL5G9aH8G5CxHZT4ZYype6lhwx6cz4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbs0MxrFHMu0H3LVAfm6oxR04oXYXcKiBIdSh3osPaG2ha5xLy
	K1EgrSzqrwKGYNyXl2dIy/An1iu7C4pCTx4j11lTExXqsRbemvEeQ4q7trBnhepCRD0=
X-Gm-Gg: ASbGncvM14Diu35ywej8YQYhuYGl+wIVyt1sUP10RWcKCilpa6K986k8x7OJh7JNzLq
	CtD7Ots0BWNXFq/UuikkG97MrSZkBokv7pW59P0rJ4LmluMBrrBId9eEqkwwxE3280cpIOUPRhB
	ULH/cZsZ4qnsBA6nt2Zz+aR2d7tu4J8MDZgNqQ/1fTMqonGsh2RmiVzTME+H9w5YLbJ75NWsMBw
	rRzSoBNH7W3fIbUKP5nrk80XG7JYfSxb2dRCZNuvqqMovm8e4YPQoHMuiREET0qWWgg92ldlLlC
	0U2XDYAkmf/cwBwEDn4O1gcqzCCp4HYY450bywnJXdODqx+F4Vz+6zlabusYxAlxO/nJIQknvv+
	RcPiPrHRkFeRxx0xibjs9Xyady+jHGiRJnCaebfzpfYj7rcx6Z0aLMF6cE8RUVMivS0pCfd7yiI
	iweWt56RPKNlKA
X-Google-Smtp-Source: AGHT+IEl3pqh9+PexvH3KC2PQlUbr9Np6CLrnpnOqU7agbJsCdYwehbiMJU1OoVTZIRJc55erxVavw==
X-Received: by 2002:a5d:5d12:0:b0:427:53e:ab25 with SMTP id ffacd0b85a97d-429bd6e3ccemr13481854f8f.49.1762273546158;
        Tue, 04 Nov 2025 08:25:46 -0800 (PST)
Received: from [192.168.15.14] ([152.234.106.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5070fsm32382905ad.75.2025.11.04.08.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:25:45 -0800 (PST)
Message-ID: <648b7b14-d285-449a-a1b3-4cd062a55b02@suse.com>
Date: Tue, 4 Nov 2025 13:23:33 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: client: fix refcount leak in smb2_set_path_attr
To: Steve French <smfrench@gmail.com>, Shuhao Fu <sfual@cse.ust.hk>
Cc: Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>,
 Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 Steve French <sfrench@samba.org>, Bharath SM <bharathsm@microsoft.com>
References: <aQoYCxKqMHwH4sOK@osx.local>
 <CAH2r5mu7s4p88RhUbCm5mqUvEVM60OOTTJOZ+rz09nFfc+t3mQ@mail.gmail.com>
Content-Language: en-US
From: Henrique Carvalho <henrique.carvalho@suse.com>
In-Reply-To: <CAH2r5mu7s4p88RhUbCm5mqUvEVM60OOTTJOZ+rz09nFfc+t3mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/4/25 1:12 PM, Steve French via samba-technical wrote:
> There are multiple callers - are there callers that don't call
> "set_writeable_path()" ?    And so could cause the reverse refcount
> issue?

Yes... Even if it does not cause an issue today, that fix looks like it
belongs inside smb2_rename_path?

> 
> On Tue, Nov 4, 2025 at 9:21 AM Shuhao Fu <sfual@cse.ust.hk> wrote:
>>
>> Fix refcount leak in `smb2_set_path_attr` when path conversion fails.
>>
>> Function `cifs_get_writable_path` returns `cfile` with its reference
>> counter `cfile->count` increased on success. Function `smb2_compound_op`
>> would decrease the reference counter for `cfile`, as stated in its
>> comment. By calling `smb2_rename_path`, the reference counter of `cfile`
>> would leak if `cifs_convert_path_to_utf16` fails in `smb2_set_path_attr`.
>>
>> Fixes: 8de9e86c67ba ("cifs: create a helper to find a writeable handle by path name")
>> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
>> ---
>>  fs/smb/client/smb2inode.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
>> index 09e3fc81d..69cb81fa0 100644
>> --- a/fs/smb/client/smb2inode.c
>> +++ b/fs/smb/client/smb2inode.c
>> @@ -1294,6 +1294,8 @@ static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
>>         smb2_to_name = cifs_convert_path_to_utf16(to_name, cifs_sb);
>>         if (smb2_to_name == NULL) {
>>                 rc = -ENOMEM;
>> +               if (cfile)
>> +                       cifsFileInfo_put(cfile);
>>                 goto smb2_rename_path;
>>         }
>>         in_iov.iov_base = smb2_to_name;
>> --
>> 2.39.5 (Apple Git-154)
>>
>>
> 
> 

-- 
Henrique
SUSE Labs

