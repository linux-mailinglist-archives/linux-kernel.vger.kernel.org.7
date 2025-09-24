Return-Path: <linux-kernel+bounces-831319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A5B9C584
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2780E7A7E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EB2288C0E;
	Wed, 24 Sep 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i54jFpgH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46F1B423C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752358; cv=none; b=tLQhhnXeBqxEo2ivNYtHR1+v+v9qKsOxfT+ChgZkqxfQvOSFd1p7jCrrimxKqwm3JjA+g/wFaaQK3fXDngGFQjt3ut0X2DYNqlKiaClZTDJpFBhlrw3tx9mEVpDUVcVF3qgOBH3O0H0/ELsteg/ryJ/np8JAMBzFhKovU9/NbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752358; c=relaxed/simple;
	bh=DwTYEgj5T/CHedqcOjd2aWq+0eOsAsJoVex7duddAUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfElqaWf4rizedBrKy5y/udhNa0O3bJXURNq+sbfuyUlTfCg8HQ7J6pihpUL/BjWj4MeHZ3Hx6FM8N3Da1LCSGbiQ4UAdUoB/gb2dF0y/dvvRn9iErMQlxSS4pe4tNsLsyt2viz9oRG+Ie4npFM6CWvxOa1QhMFcgoh2ntpiqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i54jFpgH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758752355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoxVF2uix1hiFIsyK/sDhjtjpxiyaNQ2e13qbzieQug=;
	b=i54jFpgHiEyeipovIz1bTjaPGranptb0MDobH9eNlr10Ix6HKkhhX6+DfQI70UdEg1R6/m
	sgtN4TcFe7Zq1wNeGoter3Oau95hYEiUOcrwT7r5hgue14W+gbMHBuKq7PWG6VTiuhBgwR
	FZsvs99RDDkYwZ4n5Bp9ZebD7CVJ4Y8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-cIZbKhqON5aYFlin0MzIjg-1; Wed, 24 Sep 2025 18:19:14 -0400
X-MC-Unique: cIZbKhqON5aYFlin0MzIjg-1
X-Mimecast-MFC-AGG-ID: cIZbKhqON5aYFlin0MzIjg_1758752353
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42590870dc0so6806535ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758752353; x=1759357153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoxVF2uix1hiFIsyK/sDhjtjpxiyaNQ2e13qbzieQug=;
        b=gcT63Wg5acARe/Mahc8/+81iVSoXy/rbwnK0UJS4UnVAuIJSEsNkhIeFjOBO6SpOIW
         lDAyFc8XJaxHy0z/KJAgPw8XJMrkcFUlKqOk7vkHfEYZxERkwqDlAanVyyKDGKzx4uOQ
         XF7CCuZ6z8G+E3S+VcqDZ+RrTCHqkIx5kzgXSwghbliLPyX3veH0IwJNt8fm1jJk/tKQ
         T2uAXZNGjjy9XnMBIalEpVnZnjc7ezVXf+VZ7LJFDAGBwYUjQq2NWu84PCT/f6+4+uI5
         R33rNLFn2ErRGj1zLrsTKxO56T6Uq+uGGetwui4zLSE/4o0I69deZjvyMaqNcH94p9ZV
         8w8g==
X-Forwarded-Encrypted: i=1; AJvYcCXODKI+goium/pq/X+nuPVvGr1VhqUKvzMvlRJbTjLkriU0nuZM6cnnAPrg369rcGRR/6jOcwQwkOdm9Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVjS5cJESKMhwxZA/NbtyPAuh/czaxjPUruO6PXtm2mQkfpVr
	GxfyyCs4zEvgR4qrzp1O/jskSaDKOVIF2lYaUGcrciVHJ+dhkc1pcL70E+HP9RoUJRIhH1XoaHZ
	b3YcJe3qoK91eA0xgQrpvwP3PGuXBKn/P3FQuDt2llRQpELFSQz9PG9FA715giwg4MA==
X-Gm-Gg: ASbGncuIUHS673yzkJnvOPR44BRb9SeUb7mQhV9N7srTMgKPRj93/0ov80ZxcrXx+t1
	1Z7sSOHahTpu1GA6oDyCWMR/e2t3RgtIz7yQ0dAlmqRpX6kBPhHdK2q5quQ2+19WMxLBq9VS35E
	vVbfshmPna0BVqtbKONCPo/4747Q+xXASnqmP1Rdxl2IYQSGaiFdyXwlZuO6lf+D2HdKSkGv98Z
	xE5wPSNApf2EH0QdCK2Znc6BeX+9ZJUmqns4QgU3G5HNExDxJK7UXn7ryDcXlphjF1khl3OkHG8
	h5iry7iTDM+ox899LrkyJPZo8p2HssdOawHrVpjS8Yw6sdwoOPdb/KwuCc0hD/qXCK7qFCA+yQ=
	=
X-Received: by 2002:a05:6e02:2183:b0:424:14a4:5064 with SMTP id e9e14a558f8ab-42595512c30mr19894365ab.0.1758752353373;
        Wed, 24 Sep 2025 15:19:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq3DEJlYMGhG4uQwgDYY4d6uwWfdEYxk5dGEAVU2bqGgJBERfZcb+3HJmLjQwq2cBsbtgd7A==
X-Received: by 2002:a05:6e02:2183:b0:424:14a4:5064 with SMTP id e9e14a558f8ab-42595512c30mr19894135ab.0.1758752352947;
        Wed, 24 Sep 2025 15:19:12 -0700 (PDT)
Received: from [10.0.0.82] (174-20-23-24.mpls.qwest.net. [174.20.23.24])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a647dd185sm152515173.13.2025.09.24.15.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 15:19:12 -0700 (PDT)
Message-ID: <1edd88ee-30a8-4cfd-aa88-c181c4ab3f48@redhat.com>
Date: Wed, 24 Sep 2025 17:19:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next V2] 9p: Correct the session info
To: Dominique Martinet <asmadeus@codewreck.org>,
 Edward Adam Davis <eadavis@qq.com>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
 lucho@ionkov.net, syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
References: <tencent_074BFE748F778366103D0B36E0971837E809@qq.com>
 <tencent_85467F89852EDEEEF58C8F67D446F592F106@qq.com>
 <aKlg5Ci4WC11GZGz@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aKlg5Ci4WC11GZGz@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/25 1:34 AM, Dominique Martinet wrote:
> Edward Adam Davis wrote on Sat, Aug 23, 2025 at 07:22:13AM +0800:
>> syz report a shift-out-of-bounds in v9fs_get_tree.
>>
>> This is because the maxdata value is 0, causing fls to return 32, meaning
>> the s_blocksize_bits value is 32, which causes an out of bounds error.
>> The root cause of this is incorrect session information obtained during
>> fill super. Since v9ses is stored in sb, it is used directly.
> 
> Thanks for the patch.
> 
> Eric, ignore the other part of the thread -- I guess the int max limit
> wasn't related...
> 
> What I'm not following now is how the v9ses is created/handled around
> the new mount API:
> - in v9fs_get_tree a v9ses is allocated and passed along in
> fc->s_fs_info (that this patches now uses)

This one should exist for the lifetime of the mount, and is the real,
live session info.

> - but in v9fs_init_fs_context then a `v9fs_context` is created that
> also embeds (not a pointer) a v9ses struct, which is accessed through
> fc->fs_private as the code before this patch.

This one should be ephemeral, used to hold options during mount/remount.
(see the patch description for
"9p: create a v9fs_context structure to hold parsed options")

The idea is that the v9ses within the v9fs_context is used to hold
state/options while parsing or reconfiguring. Its lifetime is only during
mount/remount, and freed in v9fs_free_fc when that is done.

Before it is freed, at the end of mount/remount, the values stored in it
are copied into the "live" v9ses in v9fs_apply_options().

> So at least for some time we have two v9ses which obviously don't hold
> the same fields, and I'm not confident I can review which is used where
> and when.

The one within v9fs_context should only store options during parsing,
and those options are transferred to the "real" v9ses when parsing
is complete.

Re-using the v9ses structure was just convenient; IIRC there might be fields
in there that aren't needed during parsing (i.e. slst), but it was an easy
way to keep things in sync. We could create a new similar structure with a
new name, if that's better.

> Now I probably should read up about the "new" mount API, but I don't
> like that there are two v9ses around.
> I don't have a clue about the fs_context lifetime: is it kept around all
> the time the fs is mounted and can we rely on it to be present (and get
> rid of the v9ses allocated in v9fs_get_tree), or is the context only a
> temporary thing and we should avoid having a v9ses in there instead?
> (I'd be tempted to think the later?)

the context is created and initialized in fsopen, and is destroyed
when the operation is complete and userspace closes the fd it got
from fsopen.

> Edward, thanks for investingating this; at this point I'm worried there
> are other inconsistencies so I'll just remove the new mount API patches
> from my -next branch instead of applying the patch, but this is really
> appreciated.

So, back to our regularly scheduled bug programming ... ;)

>> Fixes: 4d18c32a395d ("9p: convert to the new mount API")
>> Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>> V1 -> V2: remove the unused ctx
>>
>>  fs/9p/vfs_super.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
>> index f6065b5e0e5d..bcb6ebdb8037 100644
>> --- a/fs/9p/vfs_super.c
>> +++ b/fs/9p/vfs_super.c
>> @@ -49,8 +49,7 @@ static int v9fs_set_super(struct super_block *s, struct fs_context *fc)
>>  static int v9fs_fill_super(struct super_block *sb, struct fs_context *fc)
>>  {
>>  	int ret;
>> -	struct v9fs_context	*ctx = fc->fs_private;
>> -	struct v9fs_session_info *v9ses = &ctx->v9ses;
>> +	struct v9fs_session_info *v9ses = sb->s_fs_info;

This seems correct (though we can get rid of *fc too right?) 
To get here (v9fs_fill_super), we've gone through:

v9fs_get_tree(fc)
	// this will be our real live v9ses for the mount
	v9ses = kzalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);

        v9fs_session_init(v9ses, fc)
		// copies fc/context options in context v9ses
		// into the "real" v9ses
                v9fs_apply_options(v9ses, fc)
		// inits maxdata on the real, live v9ses
		v9ses->maxdata = v9ses->clnt->msize - P9_IOHDRSZ;

	fc->s_fs_info = v9ses;	// real, live v9ses on fc->s_fs_info now.
        sb = sget_fc(fc, NULL, v9fs_set_super);
		s->s_fs_info = fc->s_fs_info; // live v9ses on s->fs_info now
                err = set(s, fc)
			v9fs_set_super(s, fc)
				// assigns s->s_fs_info to fc->s_fs_info
				// but I think this is redundant
				// and should be removed
				*v9ses = fc->s_fs_info;
	                        s->s_fs_info = v9ses;
				return set_anon_super(s, NULL);

        v9fs_fill_super(sb, fc)

and yes, with my patch were were using the option-holding "v9ses" here,
not the actual, fully initialized, legitimate v9ses for this mount, and
because v9ses->maxdata is not something that gets options parsed into it,
it was unset, and it so hit this bug. :(

Going back to the prior explanation of the fc context, it's probably
a better idea to not re-use the v9ses struct "for convenience" and
make a new dedicated structure just for option parsing, so unset
structure members aren't even present and therefore inaccessible.
I'm sorry for the mistake.

I should spin up a new version of the series fixing this and the
uint32/int32 difference you spotted as well, and credit Edward for his
fix in the new commit log somehow?

Thanks,
-Eric

>>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>>  	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
> 


