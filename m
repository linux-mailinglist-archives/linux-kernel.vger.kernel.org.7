Return-Path: <linux-kernel+bounces-830607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0CB9A1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B27189D9D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5AE3043CF;
	Wed, 24 Sep 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTUrcb+S"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CC2FC89C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721653; cv=none; b=RmToMc/LB6y433N2V8CLx7xEP2FsI2rFNYz3t+glXFxsfOHq8CU1m83JLzMOq2RAcnqkJBp1mCNjQ5uuUtfKD11y+MZ8PAimKU00uUVnTssQp7w1UnOo+w8S7c9eX/gjQn0+bSAJRd27+ZpaKJ/Ip5fPyBrTRvmtFEyrswLk1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721653; c=relaxed/simple;
	bh=yl8FSVUt92YjlBnKvi98gzUpBMyOmOIsNLpV1qVAls4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=jMnVv/KlgRNNyUP2VAU302VmPWY16L2ikHJ24FAUGIwGOCwCN4ewbM+rr9+aMKG0HPX+cQYBYnqcoXVOnZITeuCzX9IMNn7ciaNKiDyHh3lNgvmg8nM79LW96LaF/olDkOkaDprRQGBtfu65GWy3TwGbdJTBjuheqtiOelwOCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HTUrcb+S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yl8FSVUt92YjlBnKvi98gzUpBMyOmOIsNLpV1qVAls4=; b=HTUrcb+S9OvFOrmkpCNl3+eMmI
	l5SReSW4QXzt+jR/BKFeIWHfDaExRgCu3FNSTqkKvE3H3VbN3YnUJtepF7MtIIG8cc4xQZqg5vgvz
	5aOLprET5VKEbgqwlzM9JHr98UOKSMPP/WPiQbtGF4LjAZAvjqj2rElaKqRgfNMx1kAIC0BSgw1Po
	f29g9jOjynhqDq75hNbLmDNV3GYvuCOTNi59X5cDnpvejnp1uhTygkJMo+IypXH9iqQXK4QQMHFyf
	y3usefwR+2tnG7CV1NcIevsEPzgILrOtN+JvOSera5Stjgp+Eq4PJSj4j3U5y91Pj7fuVmH+UGdOU
	Jh3h4Hnw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1PqD-0000000GLzB-0Kn3;
	Wed, 24 Sep 2025 13:47:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F08EA30033D; Wed, 24 Sep 2025 15:47:27 +0200 (CEST)
Message-ID: <20250924134507.288529132@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 15:45:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alexandre.chartre@oracle.com
Subject: [PATCH 0/3] objtool: Few x86 decoder updates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

few patches that update the 0xea/udb situation and fix up the x86_64 NOP
decoding.


