Return-Path: <linux-kernel+bounces-827778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6AB92C47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F40F17FB42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDFB31A7EF;
	Mon, 22 Sep 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PvD6U0Z4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3926E711
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569022; cv=none; b=Ul9w4sci5QnYFeyFfM8pVjxsWP3zedIy1Xa9khL/vNcQfgJqgULDdg5uLVfPX9v2rsyp7cISu4ixlP/CNswbw4IwH6nRmTM1W/gPk7WqEyrOndi4m0yuzmRoosfh3RxcSf2xu79aMk3GAcIVrYw92V8+vofs9kqKmvblDhfU5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569022; c=relaxed/simple;
	bh=nszw2Nr9+NXFUkNJkgCSKhFDdTfSToPsVJsT93XPULI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZ8nogA/K1pfpMyQtzylGags9VnVzBAq+cegQ/moHMLj13tJK3c0KG/NVc6480LZrcYXlLGZjcZiVBiAOb7IyhddQBiSOPSVMOfYKWMSi1QVDiPL/Foe1Gjc4BXmRzA9LEZdM5lS4qjWU1nSXG0l3ntOuN09cjK5MBsqmY81HT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PvD6U0Z4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso33881155e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758569017; x=1759173817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jA9FuvL3uiVNLGbgILOsv8b+OJuKH/FwjyuSsxB53Qo=;
        b=PvD6U0Z423KUC5VbB0kGxIiUxLqFZDKrdLSdkCm5BUiyMwsL8QMiSZZCLJQiqOBiga
         u0GecOQycbw3idvx7m0p2NBNoV3SyahIvzDKePGvR4ueJgq9GJH5FS9eYdyjgejtfw+D
         IVa5iVp/SfUc2hCXCtBHPTgHuviBLkUJ75MSbPsingW8Aj8cOP2GF58r+cqmq1C0Oa8L
         DvN2EPT4VT0fya2HeG94jEA/PzIthnk8Dfk3VL+lT9QGZYpmr7Ub244/qrrxJxkFtZ5c
         HELsHvtPTTlzTbmUOiGSKS0Fa95e58Jqw4Y6p10fVNBHFbXH6VGp1mEkBe47WE7u2Fqx
         3pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569017; x=1759173817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA9FuvL3uiVNLGbgILOsv8b+OJuKH/FwjyuSsxB53Qo=;
        b=K/DxZRWh0QmpxwiGB3PH0QNKa6N2O1yDvxuATyPzoX5zIex3U7mDdlir2Ojijvdwtb
         b65qI+/i3KSVSwHUbcg6n2vir92bgqH+TaZ03RapTOTxpYaZbiGtmi0HtFr/PZmjmv2c
         ENBJpREetqQNOn0qXVCKGyM8paA4ds0x/zKKjQvHvrRBpnJ8Y+AWKt+E4nPcuCcEx5ya
         OcD2EocN2lAtFpUBtFUNmhH3V8kxhJYd7FTdYWetEpwE9quT129+B/raZiV5AOFT2qgc
         16pgyZT1W8xPvyvphvpWsaZpLj8vBrUKyxZsjg98X7Ce21USaofNx1+FhORdGvtWXQ0r
         hTYA==
X-Forwarded-Encrypted: i=1; AJvYcCWKgTA9ITj0111mb9CvCFDhTZUB8+TYJrFo/PzwUXavYahsGNquyfDsIu7qzvFo4smQHcqt3aOVssCmGvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQKtZcr4MESt4mH+vbP5YUxXm6FuJ+p6J7FYqoQwTUKsONsx0
	JPWLT7Zp1gTslaiVsfJB2/c0vDxIVEtckpZkdJLA/9sPAddfiFtAEpHj5JJxO1w093A=
X-Gm-Gg: ASbGncvRZhkiy2PhQbF1lzqsDRhQ8VKZlYIpV1/FZwTRtlMToL0aBBBmXjSgiOZwQ6V
	L+1vgfTI0lgwwAwMBZFdieNqo/13oekXHhqwYeISaG+qeZVU6TdarBZ0J1CxHUk3Npcr5DL2nEF
	C3b2Getg7p5mzpQCYA5BWPsB7bLeg2IQ0ZHI3nBKFg33OaI3iHrgrAkikM4e/xQJmED70+7PKUu
	kf8jN2RjjofyJ6LIMS8EVn72mfbeWZOgXGxNX99W4kR4UOSlH/w+LbKmxshxD9+D+cZsczGTQ5j
	vN2BD30m7+U+F1O6kPV9zSvKiTHEeErJP1qEDsHNbdzGOiH0NOvn23XZN1AkJv4wBhmIBQ7RQJ/
	1sVhBao9VowYNCNU4nd3M5zhbAkfUvfSqg6W4iA9XMYpbiT0t0h02ohV9Ia+oaPnXgbJlj5o=
X-Google-Smtp-Source: AGHT+IHQU4WpoVbMoXLB5ySztL3q55JblBSN/zD3LUOvUoM9kGtx45Mjh394Sulahfn9r7LZ0i6NMw==
X-Received: by 2002:a05:6000:2f83:b0:3ea:e0fd:28e8 with SMTP id ffacd0b85a97d-3ee83d9ffcfmr8826965f8f.32.1758569016951;
        Mon, 22 Sep 2025 12:23:36 -0700 (PDT)
Received: from ?IPV6:2804:18:898:c51e:84f3:b734:4d02:e7d? ([2804:18:898:c51e:84f3:b734:4d02:e7d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26876ffsm16935716a91.3.2025.09.22.12.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 12:23:36 -0700 (PDT)
Message-ID: <64ded651-0319-4c1b-aeb9-f2229a45bd8a@suse.com>
Date: Mon, 22 Sep 2025 16:21:25 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cifs: client: force multichannel=off when
 max_channels=1
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Steve French <smfrench@gmail.com>, rajasimandalos@gmail.com,
 linux-cifs@vger.kernel.org, sfrench@samba.org, pc@manguebit.org,
 ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com,
 bharathsm@microsoft.com, linux-kernel@vger.kernel.org,
 Rajasi Mandal <rajasimandal@microsoft.com>
References: <20250922082417.816331-1-rajasimandalos@gmail.com>
 <da3e2b5a-a5da-4526-9884-8789990ebf95@suse.com>
 <qmf3xwqq4hqj4issgci2g76eghytaqxihnrp236ithh2istkkf@n4s54vp3hblr>
 <CAH2r5mu9xUQz5e1Mf-dBCNh2_y2jnxPYMhmuHr1bVqKC6atd8w@mail.gmail.com>
 <75a60a40-a6fe-40f5-9d6a-aa9ff8cbfa3c@suse.com>
 <byjdlepkzmhm6j4ap5eyzdcusl7dgq3iuhkduf3s5h4mrayj32@lzwe2rksc4ei>
Content-Language: en-US
From: Henrique Carvalho <henrique.carvalho@suse.com>
In-Reply-To: <byjdlepkzmhm6j4ap5eyzdcusl7dgq3iuhkduf3s5h4mrayj32@lzwe2rksc4ei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/25 3:52 PM, Enzo Matsumiya wrote:
> On 09/22, Henrique Carvalho wrote:
>>
>>
>> On 9/22/25 1:14 PM, Steve French wrote:
>>> . >Do we even need ->multichannel flag at all?
>>>
>>> Yes - especially in the future.   The goal is for the user to have
>>> three options:
>>> 1) (preferred) "multichannel" (max channels will be dynamically
>>> selected and can change) the client gets to choose how many channels
>>> to connect to based on what it sees in the output of the most recent
>>> query interfaces call (it can change on the fly as server dynamically
>>> adds and removes channels or networks become temporarily unreachable)
>>
>> I'm guessing this would be required while we are transitioning from
>> setting channels dynamically to having multichannel on by default, as
>> you commented below. Because once we have it on by default, I don't
>> think there is a point in having the flag.
> 
> Exactly.
> 
>>> 2) "max_channels="   This is for the case where user wants to choose
>>> the number of channels rather than have the client automatically
>>> (hopefully soon in the future) choose it for you
>>> 3) if server has mchan bugs, allow client to mount with no
>>> multichannel (or equivalent max_channels=1)
>>>
>>> But ... "remount" also has to work for the three above (and currently
>>> doesn't) and this is what I am hoping the recent patches can fix (?)
>>> but haven't tested them enough yet
> 
> I was talking more in the context of code, that it could use some
> refactoring/improvements -- I also think such functionality (hence the
> patches) are necessary.
> 
> There's no sense for me, as a user, to specify e.g.:
>   # mount.cifs -o ...,multichannel,max_channels=2 ...
> 
> Was there only a single option for this, it would be less confusing and
> wouldn't require this patch here.
> 
> 
> The below patch (PoC) is an idea I had that would make things much
> clearer for users -- have 'multipath' mount option be either a flag or a
> value option, e.g.:
> 
>   # mount.cifs -o ...,multichannel //srv/share /mnt/test
>   # findmnt -t cifs -u | grep -Eo 'max_channels=[0-9]+'
>   max_channels=2
>   # umount /mnt/test
>   # mount.cifs -o ...,multichannel=4 //srv/share /mnt/test
>   # findmnt -t cifs -u | grep -Eo 'max_channels=[0-9]+'
>   max_channels=4
> 
> 

I agree. This is clearer and we can drop one flag.

> 
> ---------------------
> 
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index dd12f3eb61dc..ad9a588c7103 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -2487,7 +2487,7 @@ cifs_get_smb_ses(struct TCP_Server_Info *server,
> struct smb3_fs_context *ctx)
>      spin_lock(&ses->chan_lock);
>      ses->chans[0].server = server;
>      ses->chan_count = 1;
> -    ses->chan_max = ctx->multichannel ? ctx->max_channels:1;
> +    ses->chan_max = ctx->max_channels;
>      ses->chans_need_reconnect = 1;
>      spin_unlock(&ses->chan_lock);
>  
> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> index 072383899e81..ceb19a58b743 100644
> --- a/fs/smb/client/fs_context.c
> +++ b/fs/smb/client/fs_context.c
> @@ -165,7 +165,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
>      fsparam_u32("max_cached_dirs", Opt_max_cached_dirs),
>      fsparam_u32("handletimeout", Opt_handletimeout),
>      fsparam_u64("snapshot", Opt_snapshot),
> -    fsparam_u32("max_channels", Opt_max_channels),
> +    fsparam_u32("multichannel", Opt_multichannel),
>  
>      /* Mount options which take string value */
>      fsparam_string("source", Opt_source),
> @@ -1252,14 +1252,16 @@ static int smb3_fs_context_parse_param(struct
> fs_context *fc,
>          ctx->nodelete = 1;
>          break;
>      case Opt_multichannel:
> -        if (result.negated) {
> -            ctx->multichannel = false;
> -            ctx->max_channels = 1;
> -        } else {
> -            ctx->multichannel = true;
> -            /* if number of channels not specified, default to 2 */
> -            if (ctx->max_channels < 2)
> +        if (param->type == fs_value_is_flag) {
> +            if (!result.negated && ctx->max_channels < 2)
>                  ctx->max_channels = 2;
> +        } else {
> +            if (result.uint_32 < 1 || result.uint_32 >
> CIFS_MAX_CHANNELS) {
> +                cifs_errorf(fc, "%s: Invalid max_channels value, needs
> to be 1-%d\n",
> +                     __func__, CIFS_MAX_CHANNELS);
> +                goto cifs_parse_mount_err;
> +            }
> +            ctx->max_channels = result.uint_32;
>          }
>          break;
>      case Opt_uid:
> @@ -1395,17 +1397,6 @@ static int smb3_fs_context_parse_param(struct
> fs_context *fc,
>          }
>          ctx->max_credits = result.uint_32;
>          break;
> -    case Opt_max_channels:
> -        if (result.uint_32 < 1 || result.uint_32 > CIFS_MAX_CHANNELS) {
> -            cifs_errorf(fc, "%s: Invalid max_channels value, needs to
> be 1-%d\n",
> -                 __func__, CIFS_MAX_CHANNELS);
> -            goto cifs_parse_mount_err;
> -        }
> -        ctx->max_channels = result.uint_32;
> -        /* If more than one channel requested ... they want multichan */
> -        if (result.uint_32 > 1)
> -            ctx->multichannel = true;
> -        break;
>      case Opt_max_cached_dirs:
>          if (result.uint_32 < 1) {
>              cifs_errorf(fc, "%s: Invalid max_cached_dirs, needs to be 1
> or more\n",
> @@ -1901,7 +1892,6 @@ int smb3_init_fs_context(struct fs_context *fc)
>      ctx->echo_interval = SMB_ECHO_INTERVAL_DEFAULT;
>  
>      /* default to no multichannel (single server connection) */
> -    ctx->multichannel = false;
>      ctx->max_channels = 1;
>  
>      ctx->backupuid_specified = false; /* no backup intent for a user */
> diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
> index b0fec6b9a23b..ff75a7cc11dd 100644
> --- a/fs/smb/client/fs_context.h
> +++ b/fs/smb/client/fs_context.h
> @@ -175,7 +175,6 @@ enum cifs_param {
>      Opt_max_credits,
>      Opt_max_cached_dirs,
>      Opt_snapshot,
> -    Opt_max_channels,
>      Opt_handletimeout,
>  
>      /* Mount options which take string value */
> @@ -293,7 +292,6 @@ struct smb3_fs_context {
>      bool resilient:1; /* noresilient not required since not fored for
> CA */
>      bool domainauto:1;
>      bool rdma:1;
> -    bool multichannel:1;
>      bool use_client_guid:1;
>      /* reuse existing guid for multichannel */
>      u8 client_guid[SMB2_CLIENT_GUID_SIZE];
> 

-- 
Henrique
SUSE Labs

