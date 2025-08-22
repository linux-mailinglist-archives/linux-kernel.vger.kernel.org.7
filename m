Return-Path: <linux-kernel+bounces-782789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A124EB32565
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B098A20989
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1BE2BE033;
	Fri, 22 Aug 2025 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PZ3ZQ+dJ"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B22264D2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755905072; cv=none; b=S3YLgoQBgnF0JB7ZDmCoYMMqXkHPdDQ3aWw2WZIENOpszQBlTByFFXdbPU1co8OCHyWumt0qKBcP/EnrpnVXEReOGDsHPOVMgB+ZQelPwbTTKrz+o1Ty885MBvmEkbFzhjjRNfTMoJguo17S+pVBNYy8ak9lu6Gd7HCc3033SNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755905072; c=relaxed/simple;
	bh=o+wqd4S7sCt3G8iTcnIOEVH5qiciN0TQLUtJAlie5Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3STi6CkmiCV4wPYyX0pCpZZR/sAbj031tLy3qrv9eXS5ZiON7T0LsE7UjyVHAm+QKYtTksD333JpIkK+s+EVzLsDAFIiuEXo74hobEKvCDBxFbBxZa4WgP6YeptQ5rwDzQ5Zojd9dDfvk24U0Gjsbse26sh6n5odvYqVn8QUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PZ3ZQ+dJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso801074a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755905070; x=1756509870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xBF2Dus+5HPOsTPotuhwmxk+F3+D3fmIWqml9zpAu4M=;
        b=PZ3ZQ+dJf3nh0E3tcCy2WVJmEoh3f4MAswhQ7x+HvMOHvgPgA4XumAeutsvfHgsq8J
         huBNNGtxSxRYLulM4G+KrwE4Ah/e1YHbRzYLTL6DGk5rdwZSh2yLs51EfADHOrl07CHG
         rx+TK6+BRoinR+ITd0+oh5yiiVvK2BqhAFDzDSVVNUPRe0yjsGBvxaeHE/VISQao6nc6
         icuOCS2lCY0TDQFKRMyoBFKAV0R/F2c6+9Jp8UQI1ZVMRqSCl3qq0jFh2L5z9iiiRUxb
         JXh2pm6WKj8g+EcP+mUMKEy4wtE5clAtRsW1tJaUqXXvkVNXlciMi6nhi2sfbdpuxYGa
         xAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755905070; x=1756509870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBF2Dus+5HPOsTPotuhwmxk+F3+D3fmIWqml9zpAu4M=;
        b=A1cFs5U0MA7vqPYu7EnrsOg7GcU2OnS2d0iSB4wM2tzKkjqKF4NUUihCje5XIGLe7y
         mrSF5YgIZPqwr7FN//49jYKE/vtr2Uv57YeEhnZV1cWFNtPENsPmJEHT/wzH6AvXpI3F
         Nbk13CkbWbwwcgZV/XREWAMbZ2+eYD1w8/nobT8wo/e2a4+ALVrvzq8XniiXoAOXhoLS
         y4mAVp5VCnsO7guzaCfdaZk3yK2IXfCEVHgTrVLwNVdqCMM+j979AEP/OO2hCioUshZy
         BZHxIY9kZvrocC4PeReyTiuWKXhe6MJJplsxrh4yUm0De9bAalzejbwGgm+fNNeYj0UH
         ynQg==
X-Forwarded-Encrypted: i=1; AJvYcCXPkqzH3VHVZYrCdnRZBW1oraQbWpVaO9zU0fQhd8T1qvgLpRx4NdyonN4O4gOmDcSAzVWijcYDyZ4sgMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlSTIVsjKhomK6YKfjI4Jilnn2FGC27FnpmUCbrxypyo79i75
	r6AoShGLPhfRDugb81q521p9B47S1qrtVuknBqlljDMdbME0CzpmcnV2/dUc/eg96phzEz6PH8M
	BKmT4SGE=
X-Gm-Gg: ASbGncuKMCdMRC4PMuCoEYSL+sS2OXzsfLIe8sIKSzy+9kw8KF37oGk+IUXPM8KB9X3
	lciDugx795V90zVhM1gTJKXl2RWmK1QCSD0O7TDH0d1BMzPTPThixQthNl7rMIdd9twDunoT/qV
	fj5vM61WW5B8Eb25cuftE85q310MdVcYu/916NmCigBvRUq/6W76akUSYJCDHzNDaQ0P7LUVC0X
	HH9LhjvEUrLQ97x3YQZofYDgUDQZ9Fy7S7Pn4Z5dLlBAZR/aXSpk/T3ms1c17jc42o+ZDuBfoQ5
	QlA4Tkfa7vDP4feKB7YTLGDyMYgQX/e3Zsbxe9kgSgti8m0fL70R8u0OZwlD8dRWqK4f8kAIT/K
	zT/zY50MpPI62vXm29UHDmpDHlXQAx3QEiCQ=
X-Google-Smtp-Source: AGHT+IGOPdGEXmRR2mAwVGtXapn/63V76VVuymCG897t1s7z5MRz3prdotm3xnlBD3jmGIw26n4uNw==
X-Received: by 2002:a17:90b:3b92:b0:325:3937:ef95 with SMTP id 98e67ed59e1d1-3253937f223mr3286045a91.15.1755905070027;
        Fri, 22 Aug 2025 16:24:30 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa4fc57sm851669a91.19.2025.08.22.16.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 16:24:29 -0700 (PDT)
Date: Fri, 22 Aug 2025 16:24:27 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sun YangKai <sunk67188@gmail.com>, clm@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, neelx@suse.com
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKj8K8IWkXr_SOk_@mozart.vkv.me>
References: <2022221.PYKUYFuaPT@saltykitkat>
 <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me>
 <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>

On Saturday 08/23 at 07:14 +0930, Qu Wenruo wrote:
> 在 2025/8/23 01:24, Calvin Owens 写道:
> > On Friday 08/22 at 19:53 +0930, Qu Wenruo wrote:
> > > 在 2025/8/22 19:50, Sun YangKai 写道:
> > > > > The compression level is meaningless for lzo, but before commit
> > > > > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > > > > it was silently ignored if passed.
> > > > > 
> > > > > After that commit, passing a level with lzo fails to mount:
> > > > >       BTRFS error: unrecognized compression value lzo:1
> > > > > 
> > > > > Restore the old behavior, in case any users were relying on it.
> > > > > 
> > > > > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > > > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > > > ---
> > > > > 
> > > > >    fs/btrfs/super.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > > > index a262b494a89f..7ee35038c7fb 100644
> > > > > --- a/fs/btrfs/super.c
> > > > > +++ b/fs/btrfs/super.c
> > > > > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
> > > > > *ctx,>
> > > > >    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > > >    		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > > > >    		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > > > > 
> > > > > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > > > > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> > > > > 
> > > > >    		ctx->compress_type = BTRFS_COMPRESS_LZO;
> > > > >    		ctx->compress_level = 0;
> > > > >    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > > > 
> > > > > --
> > > > > 2.47.2
> > > > 
> > > > A possible improvement would be to emit a warning in
> > > > btrfs_match_compress_type() when @may_have_level is false but a
> > > > level is still provided. And the warning message can be something like
> > > > "Providing a compression level for {compression_type} is not supported, the
> > > > level is ignored."
> > > > 
> > > > This way:
> > > > 1. users receive a clearer hint about what happened,
> > > 
> > > I'm fine with the extra warning, but I do not believe those kind of users
> > > who provides incorrect mount option will really read the dmesg.
> > > 
> > > > 2. existing setups relying on this behavior continue to work,
> > > 
> > > Or let them fix the damn incorrect mount option.
> > 
> > You're acting like I'm asking for "compress=lzo:iamafancyboy" to keep
> > working here. I think what I proposed is a lot more reasonable than
> > that, I'm *really* surprised you feel so strongly about this.
> 
> Because there are too many things in btrfs that are being abused when it was
> never supposed to work.
> 
> You are not aware about how damaging those damn legacies are.
> 
> Thus I strongly opposite anything that is only to keep things working when
> it is not supposed to be in the first place.
> 
> I'm already so tired of fixing things we should have not implemented a
> decade ago, and those things are still popping here and there.
> 
> If you feel offended, then I'm sorry but I just don't want bad examples
> anymore, even it means regression.

I'm not offended Qu. I empathize with your point of view, I apologize if
I came across as dismissive earlier.

I think trivial regression fixes like this can actually save you pain in
the long term, when they're caught as quickly as this one was. I think
this will prevent a steady trickle of user complaints over the next five
years from happening.

I can't speak for anybody else, but I'm *always* willing to do extra
work to deal with breaking changes if the end result is that things are
better or simpler. This just seems to me like a case where nothing
tangible is gained by breaking compatibility, and nothing is lost by
keeping it.

I'm absolutely not arguing that the mount options should be backwards
compatible with any possible abuse, this is a specific exception. Would
clarifying that in the commit message help? I understand if you're
concerned about the "precedent".

> > In my case it was actually little ARM boards with an /etc/fstab
> > generated by templating code that didn't understand lzo is special.
> > 
> > I'm not debating that it's incorrect (I've already fixed it). But given
> > that passing the level has worked forever, I'm sure this thing sitting
> > on my desk right now is not the only thing in the world that assumed it
> > would keep working...
> > 
> > > I'm fine with warning, but the mount should still fail.
> > > Or those people will never learn to read the doc.
> > 
> > The warning is pointless IMHO, it's already obvious why it failed. My
> > only goal was to avoid breaking existing systems in the real world when
> > they upgrade the kernel.
> > 
> > If you'd take a patch that makes it work with a WARN(), I'll happily
> > send you that. But I'm not going to add the WARN() and keep it failing:
> > if that's all you'll accept, let's just drop it.
> > 
> > Thanks,
> > Calvin
> > 
> > > > 3. the @may_have_level semantics remain consistent.
> > > > 
> > > > 
> > 
> 

