Return-Path: <linux-kernel+bounces-850944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A401DBD50AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7603F547128
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5568314B7C;
	Mon, 13 Oct 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tukaani.org header.i=@tukaani.org header.b="FdRB8NYq"
Received: from mailscanner05.zoner.fi (mailscanner05.zoner.fi [5.44.246.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B53081C7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370208; cv=none; b=YXuWShedG7yeLVtxzaTAWaqM+2GoL0SnJglLU8TKMwy8BO7rlOGzJKqsQgjeF9V7WLcYkTgKcOGh0HJkLNToJHPpWDm8cD9yDN4kYlGrdcN7yKEy52VjCR/zj3EhuFNIXVXkd7RUoDbwqrKevKZBIIFaH4uuHLnG8whB+3ISpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370208; c=relaxed/simple;
	bh=4uBeaNecPaRo+HlRhltZmFREEiEWTHXnbloQYeG4v/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVg7iUVZD3QhOC7EzU1Yo8R/iLwZiju/YByum9O6yuw56xnAe+NMHerlgicS6SHqKVLWzPw49HNwoouUwpSCEtdPteg6gkZ7Cp0f+o9d8kLYo13y4aAYRK1eZZmOQgiNDodFCxc/2Fr3L9qSpFp/zIDIx1Gw6GH2WpA+FVTuduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; dkim=pass (2048-bit key) header.d=tukaani.org header.i=@tukaani.org header.b=FdRB8NYq; arc=none smtp.client-ip=5.44.246.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner05.zoner.fi (Postfix) with ESMTPS id 73F3720C1D;
	Mon, 13 Oct 2025 18:38:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tukaani.org
	; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description; bh=smqYrcBk5xx37VdH50G3Vir93uIEQ2AsNGlBAIn75vI=; b=FdRB8
	NYqMkhR9HGNMWT+ipVZSRBHTAeFISM41aY0TvJiJowE6yi23MS6GbioSLQXEodpHz7kTqi9H++EH5
	o5SbqPJ0Ufs9DqNltRYmHZvdm/Ijm3+wEDDLBY3v3Tv3FMGEUAJnQcECW1xCc2JDV40jR0Mu7K4yZ
	bqxsohGBv1DlVXfle52OoPflDyI/g9Q0YGbgBhEjYcEj8eE2uRodICYB3dZIpHi/TVz6SThb3LrJm
	v0Kb/BxKNC2mDfRApUx1DQuzU79tbEHnk+dY3I557vg1T07FehaijHoULKwXHT0CywgTs0pBYfxzE
	bWwIHJB2SY4xp7/OEJapEbqGtT2Lg==;
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.98.2)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1v8Kcd-0000000Cxwf-2LKT;
	Mon, 13 Oct 2025 18:38:01 +0300
Date: Mon, 13 Oct 2025 18:38:00 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: skhan@linuxfoundation.org, khalid@kernel.org,
 david.hunter.linux@gmail.com, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Phillip Lougher
 <phillip@squashfs.org.uk>
Subject: Re: [PATCH] lib/xz: remove dead IA-64 (Itanium) support code
Message-ID: <20251013183800.7af293f5.lasse.collin@tukaani.org>
In-Reply-To: <79cebb23-5232-49f1-a0ac-b401707c2b52@gmail.com>
References: <20251013115136.16773-1-spyjetfayed@gmail.com>
	<79cebb23-5232-49f1-a0ac-b401707c2b52@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2025-10-13 Ankan Biswas wrote:
> Support for the IA-64 (Itanium) architecture was removed in
> commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture").
> 
> This patch drops the IA-64 specific decompression code from
> lib/xz, which was conditionally compiled with the now-obsolete
> CONFIG_XZ_DEC_IA64 option.

The commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
unconditionally disabled the IA-64 filter, which effectively dropped
support for mounting Squashfs file systems that use XZ with the IA-64
filter. I wasn't Cc'ed when it was committed because I wasn't in
MAINTAINERS back then. If I had been, I might have commented that the
commits [1] and [2] and the discussion [3] showed that keeping filters
available for non-native archs can be desirable. But now that time has
passed and no one has complained about the lack of IA-64 filter, it
seems fine to remove it completely from Linux.

I won't remove the IA-64 filter from the upstream version of
xz_dec_bcj.c, so this change will make those files diverge a little
more. That's unfortunate, but they already differ by a tiny amount
anyway.

xz_private.h line 106 checks if XZ_DEC_IA64 is defined. That line
should be removed too. With that change:

    Acked-by: Lasse Collin <lasse.collin@tukaani.org>

[1] 5dc49c75a26b ("decompressors: make the default XZ_DEC_* config
    match the selected architecture")
[2] bf4d064d89ae ("lib/xz: enable all filters by default in Kconfig")
[3] https://lore.kernel.org/lkml/20140228230017.GE14970@merlin.infradead.org/T/

-- 
Lasse Collin

