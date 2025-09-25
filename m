Return-Path: <linux-kernel+bounces-831718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3338B9D633
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AABE4E0465
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35F12E7186;
	Thu, 25 Sep 2025 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aasT2DUb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112A14A8E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774565; cv=none; b=uvxP+k4aw1j44pJ44E5EIQzMxAAl/LAHfhhXAlBbCiOqyW8ElGMJFNGtdvB4GHwWVmZ6DWkDoa1yMQNmnclHrEgfn6XBwRf86clxH4hvQx0pxPrusr0QxQwlT+AVZZk0afpL6iGsuRv2sh+Wn7sDnddkcKDuv90A3y6TsyvNb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774565; c=relaxed/simple;
	bh=MXwm3uuwpWecCr3B0M/+zXw2nHUbQoX6RykfjxXeSr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4wPFK8EwjMgnDO04whuYBGOtSrlpark1ZEHcbWgWPhJy1OabSByG8wKzo0YgxZ1+vJ2ORPgrvGK5sgF7bUCJU25tWMh75Ja1lgxgfAMnsQKdFQLc7YLEnYnbSPzqx+1w7ScVipH0g4KW/oB1zMeaJbXH2I0NfNzYSO8/TH+gow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aasT2DUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758774561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flwOUH2Dd+t1MVKpdWt/GlA27DQ/su91QNSr19NKCTg=;
	b=aasT2DUbmVKi+HGfg6s98YgiKJ1Sq8UQZYQw6ZvSPq4fQuKyXwv8deIbkTxhEP1+C4BqVH
	VHpmEtPYfCuciYeMtKuG+WZd4UjrYBUTzlLBok8C67JwujRp+9wK5Gz7SA5Wv/V7dznl7K
	jZsvPVt7u5t2mXQ3VmwX6FD7DypJLts=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-RdsTpnPAMxqF_y_xT6xRiw-1; Thu, 25 Sep 2025 00:29:19 -0400
X-MC-Unique: RdsTpnPAMxqF_y_xT6xRiw-1
X-Mimecast-MFC-AGG-ID: RdsTpnPAMxqF_y_xT6xRiw_1758774559
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8936161680bso57974039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758774559; x=1759379359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flwOUH2Dd+t1MVKpdWt/GlA27DQ/su91QNSr19NKCTg=;
        b=aDDhXv32LtQ6Fbw/pN3IbEZPkPmovQic4d67KQQKMkR7guHZgAOeM1gR8qXm7ZCIf6
         pv6LlKnd9Zctsa3C5V3AUg3In/SMM3AvBrTeyRv83I5Vb6zHVUPZMgJsJCqtTpLehXLO
         c5fbloEzkcYd6xqXTKZUuspmiMDJ6lu9eQhfYCCxEny/P2FfYp830y0BhdaJUyyJsSEl
         irTFBqMe6Pi1AQhi3oe9IDGFByg6pVgqoeABYCezMYy/hRQWwicMIOxrLUbBEVz+ZZqZ
         4uU93mcZbkb3PHOQhG/AI/HpZd55d7HG+RZwW5yvg7Sz444uq4uzN83woogN1AbDAX2H
         1fmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNNH7jNwxqMXMGtQkupMvt9LTVTnU6/esow0z+a7EO39FIUQZQBxEYm8+UUjIiI0OYaoj9O0l5XaqHzfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7syoXgzGVc8y76DYtUhYR4Do/D7VID+5OJ+UsRKbQnrc79jcw
	7WSxspenVK0vBSPC1So40Ad0YKJHQJ2szuBPTG+H8be4NwwC/JD20Nz76YflP3bJ0S5cIRan1S0
	RKUYbpHfGS/AuCjBTEeqM/ERoRqfc9bSb5dDiv2IDJ6opcppzkvaTBGadThYEFf4Wxg==
X-Gm-Gg: ASbGnct+eh7YtoClvtPbTIy0+1yuv7UC44ihMcWgFyoxyoUzK1zOLgZaeNQXZWmGv1m
	msijvcsmMa5v+z8wyqqoaKJlBuA9UY2CYzvFluyRYO2Lvg/Yzfg1I8ucnqEzaIwU2ws5ltc+CBe
	K0D+GG/jHk4q5CvrX24Vt+0I/X14rrOaVjGSksNKbsWs1R//LOs+7i88sTIDq4F9DbS44pBrUYh
	5Lwn8xQZwmGfGq/e1y7lDW5fmYdpEPzsFl/edmSteUeAlkkY2EJ59KcWtrz6MGIVZjEYgdDkw1Q
	acDWIdmcVMWWLp72xthcfBCVq1c10X5tBRBouoEtVDQaqKuUpFAPeGqI3u9+DpN7KXIUMXXHIg=
	=
X-Received: by 2002:a05:6602:408a:b0:875:d675:55f2 with SMTP id ca18e2360f4ac-90153fd19f6mr402048639f.7.1758774558890;
        Wed, 24 Sep 2025 21:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlNtsXoekaI13YDS6FFTFs4QsLvr4hpiD5QL8mEAdeMbZhRGIZisEc928mJ3wFz7LNVLB5yQ==
X-Received: by 2002:a05:6602:408a:b0:875:d675:55f2 with SMTP id ca18e2360f4ac-90153fd19f6mr402045939f.7.1758774558430;
        Wed, 24 Sep 2025 21:29:18 -0700 (PDT)
Received: from [10.0.0.82] (174-20-23-24.mpls.qwest.net. [174.20.23.24])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-903facb41b2sm34543039f.9.2025.09.24.21.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 21:29:17 -0700 (PDT)
Message-ID: <45072767-8ed5-4abc-895b-9a4f5429bd3e@redhat.com>
Date: Wed, 24 Sep 2025 23:29:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next V2] 9p: Correct the session info
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Edward Adam Davis <eadavis@qq.com>, ericvh@kernel.org,
 linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
References: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
 <tencent_85467F89852EDEEEF58C8F67D446F592F106@qq.com>
 <aKlg5Ci4WC11GZGz@codewreck.org>
 <1edd88ee-30a8-4cfd-aa88-c181c4ab3f48@redhat.com>
 <aNSmO8iou5dJ1VHq@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aNSmO8iou5dJ1VHq@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 9:17 PM, Dominique Martinet wrote:
> Eric Sandeen wrote on Wed, Sep 24, 2025 at 05:19:11PM -0500:
>>> What I'm not following now is how the v9ses is created/handled around
>>> the new mount API:
>>> - in v9fs_get_tree a v9ses is allocated and passed along in
>>> fc->s_fs_info (that this patches now uses)
>>
>> This one should exist for the lifetime of the mount, and is the real,
>> live session info.
>>
>>> - but in v9fs_init_fs_context then a `v9fs_context` is created that
>>> also embeds (not a pointer) a v9ses struct, which is accessed through
>>> fc->fs_private as the code before this patch.
>>
>> This one should be ephemeral, used to hold options during mount/remount.
>> (see the patch description for
>> "9p: create a v9fs_context structure to hold parsed options")
>>
>> The idea is that the v9ses within the v9fs_context is used to hold
>> state/options while parsing or reconfiguring. Its lifetime is only during
>> mount/remount, and freed in v9fs_free_fc when that is done.
>>
>> Before it is freed, at the end of mount/remount, the values stored in it
>> are copied into the "live" v9ses in v9fs_apply_options().
> 
> Thanks for clarifying this;
> 
> I had which is a pointer and which is embedded wrong on the first
> reading so I first wrote that this should be ok if we could just null
> the pointer in fs_private to avoid access after the copy, but the
> temporary values are the embedded ones we can't "unaccess"...
> Hmm, do we need anything else in fs_private after v9fs_apply_options()?
> Would it make sense to call v9fs_free_fc() early on and null the full
> fs_private in or after v9fs_apply_options()?
> 
> Using a different struct tailored for mount options is certainly more
> appropriate if you have the time to do it, but as long as the risk of
> accessing "the wrong one" goes away I'm fine either way, so if you think
> nulling fs_private is possible without too much churn I think that's
> good enough.
> 
> What do you think?

I think that in retrospect, (ab)using the full v9ses was a poor choice by
me, it clearly caused confusion (for me!)

>>>> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
>>>> index f6065b5e0e5d..bcb6ebdb8037 100644
>>>> --- a/fs/9p/vfs_super.c
>>>> +++ b/fs/9p/vfs_super.c
>>>> @@ -49,8 +49,7 @@ static int v9fs_set_super(struct super_block *s, struct fs_context *fc)
>>>>  static int v9fs_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>  {
>>>>  	int ret;
>>>> -	struct v9fs_context	*ctx = fc->fs_private;
>>>> -	struct v9fs_session_info *v9ses = &ctx->v9ses;
>>>> +	struct v9fs_session_info *v9ses = sb->s_fs_info;
>>
>> This seems correct (though we can get rid of *fc too right?) 
> 
> (Sounds right as nothing else seems to use fc)
> 
>> To get here (v9fs_fill_super), we've gone through:
>>
>> v9fs_get_tree(fc)
>> 	// this will be our real live v9ses for the mount
>> 	v9ses = kzalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);
>>
>>         v9fs_session_init(v9ses, fc)
>> 		// copies fc/context options in context v9ses
>> 		// into the "real" v9ses
>>                 v9fs_apply_options(v9ses, fc)
>> 		// inits maxdata on the real, live v9ses
>> 		v9ses->maxdata = v9ses->clnt->msize - P9_IOHDRSZ;
>>
>> 	fc->s_fs_info = v9ses;	// real, live v9ses on fc->s_fs_info now.
>>         sb = sget_fc(fc, NULL, v9fs_set_super);
>> 		s->s_fs_info = fc->s_fs_info; // live v9ses on s->fs_info now
>>                 err = set(s, fc)
>> 			v9fs_set_super(s, fc)
>> 				// assigns s->s_fs_info to fc->s_fs_info
>> 				// but I think this is redundant
>> 				// and should be removed
> 
> My reading is that we need it, because the super block isn't the fs
> context, and we need it for v9fs_umount_begin (it doesn't help that the
> field name is the same between both structs, and that some super_block
> variables are just 's' and others are 'sb', but I think that's the only
> place where it's used)
> 
> At this point these are both the "real live" v9ses so that should be
> fine as far as I can see.

I said remove because sget_fc() does s->s_fs_info = fc->s_fs_info, and
then v9fs_set_super essentially does s->s_fs_info = fc->s_fs_info again,
so I think it's redundant but I'll look again when I'm less sleepy. 
>> 				*v9ses = fc->s_fs_info;
>> 	                        s->s_fs_info = v9ses;
>> 				return set_anon_super(s, NULL);
>>
>>         v9fs_fill_super(sb, fc)
>>
>> and yes, with my patch were were using the option-holding "v9ses" here,
>> not the actual, fully initialized, legitimate v9ses for this mount, and
>> because v9ses->maxdata is not something that gets options parsed into it,
>> it was unset, and it so hit this bug. :(
>>
>> Going back to the prior explanation of the fc context, it's probably
>> a better idea to not re-use the v9ses struct "for convenience" and
>> make a new dedicated structure just for option parsing, so unset
>> structure members aren't even present and therefore inaccessible.
>> I'm sorry for the mistake.
>>
>> I should spin up a new version of the series fixing this and the
>> uint32/int32 difference you spotted as well
> 
> That would be great!
> 
> I'm not sure the unsigned makes much different ultimately, but might as
> well make it a fsparam_s32 as you suggested...
> Now I understand the lifecycle a bit better I can have another read with
> that in mind before merging, and we can do the nulling fs_private or
> other "make sure this bug doesn't come back" later if you don't have
> time, I'm leaving this up to you.

Sounds good. Thanks again, and sorry for somehow completely missing this
thread earlier.

(Assume we've missed this merge window by now, so I probably won't rush
on this but will try to do it sooner than later.)

Thanks,
-Eric

>> and credit Edward for his fix in the new commit log somehow?
> 
> I've never really been sure what kind of tag is appropriate in this
> case, but I assume any mention would be welcome :)
> 
> 
> Thanks,


