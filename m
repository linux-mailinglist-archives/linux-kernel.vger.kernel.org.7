Return-Path: <linux-kernel+bounces-776098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849B4B2C896
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4087A5239F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D848242D70;
	Tue, 19 Aug 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="LiM2QbQC";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="adNl8qBd"
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAFA23E32B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617817; cv=none; b=Dl3CJeOhEIsUHRCib25k7lU904GvgcXSCnQTOmYaY57ygtsXiJpY0axksVyyNIpDnCL0miBMn1o9GQweip0xcmQvymCOte3sIVaMTlOLEfehrAL2aJr04Y+seHAdZ04AU3ScTfJ5Fu+Cq/zmMj71ia2MjB3BJ3n0NbQGaLsgq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617817; c=relaxed/simple;
	bh=zTXOuk1o/xFRR9+KZG00Ah1/hoQ3UaExdPYCaYtUWtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XRybotA2Y47EKmBmK7+2/9kmebUYRLPiFLHNvKaNUzJNrXE5bjTUOoO53VVxQGk5KvK9BmSLdawBKqdczuqTtcx7skyhHWWmojvx0RU2ySqM8AmADf+vFuqXp6pwbqJz88gfLfl+65q9g18mIy1z2r4KDlng5oFhmKY/dGUtKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=LiM2QbQC; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=adNl8qBd; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 94CA8209679B;
	Wed, 20 Aug 2025 00:36:51 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1755617811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cmviLoaPsgUhEj7WADadlF4vtYX4Km8Q2wumhLwNAM=;
	b=LiM2QbQCVHRmqHCXwg7t0FVZaJNE+A4WTiJ9UumvxVJGABaE0IBKeHSJZ9qM+W+7TE44iV
	pMIA9xpbxazGLopnIRNGorGtDpdnzOEaILmWYxInjlp4sDYb8a6N5TctmhXopSk89YfpSm
	9zM07dcDarkInO+rOGaeKa8Y6wmdCsC57iczummSZrNQXSRUuuDY76tjc25WD9FlW8l18R
	movyawsoJ47vZN4JKdUH3+fcjB3fjiv417x7y8MeFmJpb7oeZhhHjeMm5o+zuA4eSzjRos
	TZkLw8cEK44QGpX3GqzsWD4evcYkLFwcxE/8xnrE7pVcKJiiC2xoLLC3NcEPvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1755617811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cmviLoaPsgUhEj7WADadlF4vtYX4Km8Q2wumhLwNAM=;
	b=adNl8qBdFv5E9+nFypZCmA/gU1FfHY5tTOofC0YSL7H1mLy/UJTBWNcRvVh3fABCco3cJT
	xOWsVJX34Bqjf6Bw==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 57JFaoBJ031114
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 00:36:51 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 57JFao40003768
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 00:36:50 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 57JFaoJT003767;
	Wed, 20 Aug 2025 00:36:50 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: zhoumin <teczm@foxmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfat: fix uninitialized i_pos error
In-Reply-To: <tencent_8DDA7086C9B39312179B5CE9430B891C1605@qq.com>
References: <tencent_8DDA7086C9B39312179B5CE9430B891C1605@qq.com>
Date: Wed, 20 Aug 2025 00:36:50 +0900
Message-ID: <87o6sbz5kd.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

zhoumin <teczm@foxmail.com> writes:

> The i_pos field remains uninitialized when fat_fs_error_ratelimit() reports
> error, e.g.,
>
> 	[ 1642.703550] FAT-fs (loop0): error, fat_get_cluster: invalid
> 	cluster chain (i_pos 0)
>
> Since i_pos is assigned in fat_attach after fat_fill_inode, the error
> message lacks useful debug info.
>
> Path:
> vfat_lookup
> 	fat_build_inode
> 		fat_fill_inode
> 			fat_calc_dir_size
>           			fat_get_cluster /* report error */
>       	fat_attach  /* i_pos assigned here */

No. It is initialized as 0, and it must be unavailable outside
between fat_attach and fat_detach.

IOW, this is introducing the race.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

