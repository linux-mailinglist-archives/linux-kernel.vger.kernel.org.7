Return-Path: <linux-kernel+bounces-731069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53133B04E78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1421895AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57074246787;
	Tue, 15 Jul 2025 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqEiUlXV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F62B9A4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752548553; cv=none; b=hFedtXZNkVeGVNVyGTAH+sKxEY9fqUHAkKFS5EZbopQKRhGwQoWBYPOuADEMSBXOEa1uFNX32rbPK4u5eaCgpw6FQfOvIiM85sv9zKyLSVuv0HmlilbKR2649Y25/OjjLbWS93l5cXMtRAkOZdfPrcsJXlfmttGkMrC8C6SFOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752548553; c=relaxed/simple;
	bh=5iBcZMnLTgHM9MfCl/SxgkXgSxL749d/lCzwTN6LZak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhmfCDR7t3DKne7Z1gdAa9u+w2o18boyfZ8I+ZblHmlP4MwxS0XVvnHZBbyw0nYS0w25DftvaTQ90cJ8zECx7AdHgg763jo+qpndBkfbx4+VhPDYpEn6TiSQehAPIuhDO3pP/m3y28kkNb7uH9rQWBvjnzIIbS19nOS4SIKy5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqEiUlXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A7CC4CEED;
	Tue, 15 Jul 2025 03:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752548553;
	bh=5iBcZMnLTgHM9MfCl/SxgkXgSxL749d/lCzwTN6LZak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqEiUlXVD5AeZdBDRBxLaOQn+hgXov9fxSBQWT8uTYYp9vsKO8QSR/jXjgQvkuV+d
	 fRWUiqqP0OP9IqNCtfEGF6CrMA+zwkF5xl4wKjhfrAB5Va02RH0uEEmu2EEaUdQalw
	 y/808ihsaNg2b+792mzTtvNFN/cwUEK512qwUdWJNrwNW/rwGaKF0vZ+M3Im9bJt/T
	 QJhp+KNq38KcN8Cod4FTuRFHV7Cp32j628ZfME0aTdzMFsUiCrx6UK2Sh+5+oZeIsL
	 dYGGKkS3B92CI+tGPrnKxRwPeL2I7X0DGnq+Vu4pS93YxPR4aL4F6Cvw8cMRHGbFAK
	 nSlIokg2F//yA==
Date: Mon, 14 Jul 2025 20:02:31 -0700
From: Drew Fustini <fustini@kernel.org>
To: guoren@kernel.org
Cc: palmer@dabbelt.com, conor@kernel.org, alexghiti@rivosinc.com,
	paul.walmsley@sifive.com, bjorn@rivosinc.com, eobras@redhat.com,
	corbet@lwn.net, peterlin@andestech.com, rabenda.cn@gmail.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V2 2/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Message-ID: <aHXEx2a0qgiPXhBS@x1>
References: <20250713155321.2064856-1-guoren@kernel.org>
 <20250713155321.2064856-3-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713155321.2064856-3-guoren@kernel.org>

On Sun, Jul 13, 2025 at 11:53:21AM -0400, guoren@kernel.org wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> The early version of XuanTie C910 core has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 & th1520 platforms with the qspinlock
> lock torture test.
> 
> So appending a fence w.o could immediately flush the store merge
> buffer and let other cores see the write result.
> 
> This will apply the WRITE_ONCE errata to handle the non-standard
> behavior via appending a fence w.o instruction for WRITE_ONCE().
> 
> This problem is only observed on the sg2042 hardware platform by
> running the lock_torture test program for half an hour. The problem
> was not found in the user space application, because interrupt can
> break the livelock.

The first paragraph states the problem was found on both the SG2042 and
TH1520, but this paragraph states it is only observed on the SG2042. Is
worth me trying to run lock_torture on the TH1520 for many hours?

Thanks,
Drew

