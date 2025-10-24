Return-Path: <linux-kernel+bounces-869216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630BBC07505
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D84119A24A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72C336EE2;
	Fri, 24 Oct 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="dFkeTwAT"
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FC32C950;
	Fri, 24 Oct 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323293; cv=none; b=qt19WD3EDH24TB0knyq5xogJQ8lOqjHax8QfFzOnPPrqbDA2zee6Uqzwk9vD37lYZGyhDck2PbC2B/T3m2aoFk7OrX7qMX1JFTh31anpiHZMz+qY4XRqGPGuEiD2zwqXH74VD+lSS99XNDafVZGfxRFRYVrY8ETvWrjk7Ui0Xl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323293; c=relaxed/simple;
	bh=/wliLZvxICaQNx4AGi7HzPgavTLVmI3gz2pxhZpQUM4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=unWHCY37AVR+WGoIf5vgp8e0HnqjGfShARjehb8ls5z0w1RnA6MWoNioSWOSk5bFUR2cEBlQdHAWtjgphA/D28LQY2ZGuOuufxcwyeyv8NtEzhuiScVA786B1s1Q1hA5hNrEwYCqC1WxRsX7mYALPTeIsvJbM12nuB4r13NJ2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=dFkeTwAT; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/wliLZvxICaQNx4AGi7HzPgavTLVmI3gz2pxhZpQUM4=; b=dFkeTwAT6A93si/lxGVbRGwzys
	uDjd3BK+vEThMDmEIrIoReeSHgl91VuL5dl1s/febCYDausaDyDJl6g+ygR2vqASyWUEOTcIvRw4g
	cvgArFccKnXH1Y2KSnr2fCmWH5aQki8s+67zqX9xEfzYJlcda/OskGr1tHxSkH8KldE+s2khiiEru
	gezDW05zFwJOUZOpinLlK3sAmyLMBCCTDjPp55f0/KacoA1jlATpJclOUE68y6OrF3lB5TRHhQ97m
	Qm94CG6Ane1koVwJq4GhIb8hi4eMMxQQ8gs7jTwDsdwJdL5u2IyLDnDWdUQyXlXNQ4uaRqsJRiOPq
	Nerw7qIg==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1vCKe9-00000000JTl-1bf8;
	Fri, 24 Oct 2025 13:28:09 -0300
Message-ID: <e6346ce513c44be5d4b02bc2a670ff75@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Call the smb3_read_* tracepoints from SMB1
In-Reply-To: <2014675.1761320570@warthog.procyon.org.uk>
References: <2014675.1761320570@warthog.procyon.org.uk>
Date: Fri, 24 Oct 2025 13:28:09 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Call the smb3_read_* tracepoints from SMB1's cifs_async_readv() and
> cifs_readv_callback().
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

