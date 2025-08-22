Return-Path: <linux-kernel+bounces-782742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA1EB324AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0213AA595
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880DF29AAE3;
	Fri, 22 Aug 2025 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="XmQJZXv8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B047258EF4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898967; cv=none; b=WDpAr5AZbRxCvXeLVE13bSB9O0qmlaHyNUQ6B5tv+vI/f/vMAnbesvStaSwhMYdtS+A887Fk2ngRfKNQndRhDnhEG83pH8rHR5hQnqqvpSBfVo3QtlezJ6rpOsNAXIxT4TNS9oVCNpfvhILS7EshNgERQM358L4Znj9sVZ4zdIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898967; c=relaxed/simple;
	bh=cSAoYlhEharbCXrFRdBZlGV8qlrCICwY5tJACo9Nzb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh9/oAKEuQfeXXhssaKdwRXcrFpYB2l6SkwgiAn+++3r1RgrGN7CZiLb1+XOPBZVoBylu9HcUXHVXC2AUwaN9OVNCE0IAaOX8N6yRONKvLQQhu1UZvmEhP5AM4TiU6Qcof+GB8IJO4FRO4SCy05+9LUXPen5Or9BjVzwjER1PRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=XmQJZXv8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e43ee62b8so1854612b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755898964; x=1756503764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRyx1vVcQ/kgaVUrmb8N/jhUWIpSwlGJJb8HvB3gHGM=;
        b=XmQJZXv8Zw4HTyY1XWfCZ8CJDcyEN7Fv5xu/EddKJkIsiE1dnW7RU3v/nnlJmUS+mO
         Ul54tF0Lkhl6DL/nfTR1qONwI1nrGNBBoKoxN1nvEoi0/9tGVgKBrU+Tgglpam95o7GJ
         5GmF37ae69EBYcSJ+9T8DQoqMk4puAOeoUmBsXjRVlEu4mgnbdiXIWhT7eEuuzLKarjL
         adc8sUdWoVNZaqnCCDlQTlg7Ggw5w7Xl7aqfke2tCYmhuBXYkovin6228Xq7P7LMTgx0
         YFKKoDSVXoh2PoLGY/IrOEQTw719W5q5jcmUOZHqDtJo4u2+r4pUNeaznNYwcxObfR5N
         Iv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898964; x=1756503764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRyx1vVcQ/kgaVUrmb8N/jhUWIpSwlGJJb8HvB3gHGM=;
        b=fb4rLYWBXz3CF7lXs8CdKXMcRDecmoq0MunoeEB8SrYPeLOpHDoQuS8kifN9amKzhZ
         nYto2Bwlw7MRFcjZZy5GxSdpwhGhSjUvQm4D9DkbqHFrjZnZQzHA5FjdSa2C83X304Al
         T8XRzA2Vp8X0Ef5HrGZHhsfoIbZTS/b2Zn/+6rhPeUS9gkFnTR6S/9gb3VzQIoWFP5+3
         8bd9WVj0lcp0A+Yu3xYXLI9rM7a2Gv7bNf0SacSySxrce/wIvdbBpGHazOgFq8fIPf+5
         nfMXx85YH7ch0v7Avhk9jiPqtRdcCwR5sKZHy9VRSCR2EwPE9qMB1gb/W46jLQaKC77u
         suaA==
X-Forwarded-Encrypted: i=1; AJvYcCXSBkHuJbnkOMkml2Kt9zi0lh74p9QSQmxG9IPNP5o8qL0y8mUDmrl/HXG3lf2Lf9RwBvyJjlEhTCVRODk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/hIILxMYqmlJgLFgsNz/8N9/hj4JTVhkEA2vZhhKo0kgvzdK
	1XKAkPbAtsTyN/7DXxFlbpptEuO9HW5A9qYo8ObFfL8Bp9PU5NWGSQOqsEkZkYzQK24=
X-Gm-Gg: ASbGncv5AgpR+x5qeT/eIAB2KwUklb3DJeLSBBY7KPkzlHVggN7UlqMtPbTICqM58d6
	arRaxb6yOIn8zHFdmrDfpaNqGdjfjU5o64J8CvLJB+MdvWUss8KT+yMECAdOS1L40aTgEyEDHiH
	HtcMIxyE6IwJ7vR4Nq85cUYyx0+meUkNtLjHJxYBn6Zhb8/x5w8g9AHi4bagQ9erVNVO1x/3C8v
	BDB0HGJvn5KObCAewoeW3bSqIQFFpcYScnFkMN++ulj8rtYUR3A1mr6WySSsD0PVQdGNQdUV1E9
	qstoCCJyzJh6rVYV7AzVQ9sHK3C65cZyXy5MxKD9I0ivTrlOIKxJKNEtCNtdNPGgcvvb/ZiGJpo
	etbQm7EsfW3MoTetugGiQWgll
X-Google-Smtp-Source: AGHT+IGp1WPtwGaTO+4dSwDCCL62mQofhBOZ94x1PTLRce8TE0h6K4r+nXiIWJq/OKRPebLfXVgPoA==
X-Received: by 2002:a05:6a00:a87:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7702f9cffc6mr5723521b3a.3.1755898964296;
        Fri, 22 Aug 2025 14:42:44 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040000c8bsm809347b3a.44.2025.08.22.14.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:42:43 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:42:41 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKjkUSL1zxL0VNGC@mozart.vkv.me>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>
 <aKg4PcgUCvXblVCY@mozart.vkv.me>
 <20250822184547.GX22430@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822184547.GX22430@suse.cz>

On Friday 08/22 at 20:45 +0200, David Sterba wrote:
> On Fri, Aug 22, 2025 at 02:28:29AM -0700, Calvin Owens wrote:
> > On Friday 08/22 at 17:57 +0930, Qu Wenruo wrote:
> > > 在 2025/8/22 17:15, Calvin Owens 写道:
> > > > The compression level is meaningless for lzo, but before commit
> > > > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > > > it was silently ignored if passed.
> > > 
> > > Since LZO doesn't support compression level, why providing a level parameter
> > > in the first place?
> > 
> > Interpreting "no level" as "level is always one" doesn't seem that
> > unreasonable to me, especially since it has worked forever.
> 
> As it currently works, no level means use the default, which is defined
> for all compression. For LZO it's implicit and 1.
> 
> > > I think it's time for those users to properly update their mount options.
> > 
> > It's a user visable regression, and fixing it has zero possible
> > downside. I think you should take my patch :)
> 
> I tend to agree this is a usability regression, even if LZO is a bit odd
> with levels, accepting the allowed values should work.
> 
> The mount options and level combinations that should work:
> 
> - compress=NAME   - use default level for NAME
> - compress=NAME:0 - use default, while accepting the level setting
> - compress=NAME:N - if N is in the allowed range for NAME then take it
> 
> The syntax is consistent for all three compressions.

Thanks David.

Maybe the below is a little more palatable? Letting the single level be
a detail so the branches in btrfs_parse_compress() all match?

But, the compression level ends up being printk'd as '1', where it has
always been '0' in the past (and still is in 6.17-rc):

    - BTRFS info (device vda state M): use lzo compression, level 0
    + BTRFS info (device vda state M): use lzo compression, level 1

With my v1 it's still always printed as zero, if that's preferable.

-----8<-----
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH v2] btrfs: Accept and ignore compression level for lzo

The compression level is meaningless for lzo, but before commit
3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
it was silently ignored if passed.

After that commit, passing a level with lzo fails to mount:

    BTRFS error: unrecognized compression value lzo:1

Restore the old behavior, in case any users were relying on it.

Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 fs/btrfs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a262b494a89f..bbcaac7022b0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -299,9 +299,10 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (btrfs_match_compress_type(string, "lzo", false)) {
+	} else if (btrfs_match_compress_type(string, "lzo", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_LZO;
-		ctx->compress_level = 0;
+		ctx->compress_level = btrfs_compress_str2level(BTRFS_COMPRESS_LZO,
+							       string + 4);
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-- 
2.47.2


