Return-Path: <linux-kernel+bounces-781502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD859B3133B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F01C86ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31F62F49E6;
	Fri, 22 Aug 2025 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="X7cEZDDF"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B32F3C16
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854914; cv=none; b=uhI4urWNpu3OpyOQfON3Y9EK91bqKqysS016yWV2OayxUVzxU6dWCKH7evqsYOz42rZxbuMUsSfvrkDXMyVeBnoeWSz1nf+Id8Ef7gAwyIP+zv01g4MrfuxQ/yfTLd+f+TaZye60BEbSRpmyBs3Kzqzij3l2a8Ju+6bqZSlhEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854914; c=relaxed/simple;
	bh=wmwgknyVkYInObDZTr2Hm600bAvuWe10GFbru4HVzms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0epEVlatE77RNqaMI+LToHqK662k2pXvk0AId3exf4QoFWrsF+ip/nJKHAUS8Rq/LTKxng4gF2zYx1xCZysz1hr/M6L7rMJYe3OSeGD5ADWw3bpuXBfox0d+ynXkDjXPu/ZhufeM6z5yIs0OMBkdeuLG7Hy3A+dpAyZEpQ2NQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=X7cEZDDF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e93370ab8so2018798b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755854912; x=1756459712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=75HTqSrm7uVdUPk6AX7RB/ymIGadUulsGOItLR1tuas=;
        b=X7cEZDDF5qKWDwS0HLezIwbUBfRBVsl2iioMkFXMP5skrxeeQ1cKYKN7TcAO1bQroY
         k2tg8ABlPo83MBiwIxw+iIYAz8sXow0m7mOW61muHLJWCq97qkHnDtqwzvqwivIKzCv5
         kujFZwKfqVuDEN/X7A6hzAl92YedWVfvO+iGsPCICYUguraC39FtjaTsRIN/vdUHCtNv
         szgS+TvSRgK3pduEPxBLf8X0ChMWdPiUXTySjKek9BaAWjrC8O137qqfe0jydUNnJ4As
         ucZkb7SlRVCUWTI0K9aGtRNJLmGfi2/EMmOu5F8OVUN/PqL+ile/VgF6zWQZtn2J0NEV
         DeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854912; x=1756459712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75HTqSrm7uVdUPk6AX7RB/ymIGadUulsGOItLR1tuas=;
        b=vGIB6gpDyK+2LYBMcojVE+DhwVgbAOj1Hu416cKM4ot3oPIsMkjQF0I1+xOGH/ZDR8
         EU3FlfKAqJL5UxGy3Ki6Ii/UYDSd20QqV4JbylU2ALu/hJcDS3y5j13/4Kwn99d82NMw
         hUCBYo1Hr24X9cRg62tlFJ3tRPuy3Ro2PnmOOR/nzwVtPuu9HNb/U/qBUckL8Bw3wz7J
         uMOzndBbEGWR8lyyrviuyQ2QOfAeX/rcBw/sZDOmN8V/4i/BO1M2D3YPaEGYlA/BtcOm
         JZ8VtibP6CXiIB42ez8CQzB3lDUwx77C2EGdgZb5ricKSAAg3zSBN44H6J9PU7NhCLfn
         l5iA==
X-Gm-Message-State: AOJu0YxmWhjx70rUx2E41lotSAeHwfUomb+EPnO1fHCR6GuAHKFZrSa4
	2LBWieywhLxO5s1L/OR6vpy3jRcwCgF5tnoOdvEqD40UqtFX0n6TcxCplNd9kaEGxc4=
X-Gm-Gg: ASbGncso/gFL8rOA881dyQc9iqcrGWPnymP7EsudjsfRBN6Sie4vUtBg5Q8Eh6nif+u
	AwLolIpKJkkGoFQkTu/0M6uu8vrvYzycuAK7PKC40qs97UVdI2cZ5MYZpOiWbJOS3mYwtPkktTl
	pb3TNAVkNDlDtnMJC5Akah2+EzHN1Cynipu4FG5b5lmOH3lrEGWYkjlQtFPZ1fsHvlT9Xo3qHnd
	QOgPsqsLVsh2R8e5JiejNLrbbOm1GB2df05WXup2mjFyyl5CdOttdpm2EMi8vS+/6CHVHXIzBre
	KMMlcxJTi6CK+iQLRrLUPV0fWOjfErkUNEO0ct8rPcKUMfiwpUMQqPIIlQWNrTiDQBOqJEBojXa
	zcAkNEK6TprK7mF8JYJGVBTHV
X-Google-Smtp-Source: AGHT+IE7bfBjxUJexxsZZW/IgJ7nBmNFkLVFwpD4zkiJn0jvfJcJvW7DjylmTmJ65B1S77Lzg+gd4A==
X-Received: by 2002:a05:6a20:6a1c:b0:243:15b9:765a with SMTP id adf61e73a8af0-24340d61060mr3857179637.52.1755854912434;
        Fri, 22 Aug 2025 02:28:32 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdd6sm10508155b3a.29.2025.08.22.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:28:31 -0700 (PDT)
Date: Fri, 22 Aug 2025 02:28:29 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKg4PcgUCvXblVCY@mozart.vkv.me>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>

On Friday 08/22 at 17:57 +0930, Qu Wenruo wrote:
> 在 2025/8/22 17:15, Calvin Owens 写道:
> > The compression level is meaningless for lzo, but before commit
> > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > it was silently ignored if passed.
> 
> Since LZO doesn't support compression level, why providing a level parameter
> in the first place?

Interpreting "no level" as "level is always one" doesn't seem that
unreasonable to me, especially since it has worked forever.

> I think it's time for those users to properly update their mount options.

It's a user visable regression, and fixing it has zero possible
downside. I think you should take my patch :)

Thanks,
Calvin

> > 
> > After that commit, passing a level with lzo fails to mount:
> > 
> >      BTRFS error: unrecognized compression value lzo:1
> > 
> > Restore the old behavior, in case any users were relying on it.
> > 
> > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> >   fs/btrfs/super.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index a262b494a89f..7ee35038c7fb 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
> >   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> >   		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> >   		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> >   		ctx->compress_type = BTRFS_COMPRESS_LZO;
> >   		ctx->compress_level = 0;
> >   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> 

