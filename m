Return-Path: <linux-kernel+bounces-889468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC84C3DB49
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3F03A6E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03D344024;
	Thu,  6 Nov 2025 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHHeTSPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C537306B09
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469848; cv=none; b=cz7GYeLVOXdUWMR4FQ7pYKUqPHERqf1cKuNG/C3HY5BH99AgEAOB+olsEILzkjpEc7MfazkoftzNeQHYoFjzDa2r54w2eqDhHU+rBvltWi8OW8NwSmsfBjPyDwkzWgmNnG6wy/nyVzpj+GRQjoWNegTdDIyEn8qItRGIxLGlZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469848; c=relaxed/simple;
	bh=QZa8ayUfWJJS+Lqb+yeeTgCdpc71cKgH26tuKpF5vVA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=kz9itIgc0rbVlzV4HHezDjV7UOGcL/0v68OprcOW+AqrzPJ6ybeis6m6If0/Ikf9dtPX/6ZKWi+Xw6YBvqR/rkqhQtRPcfeIs1KgxZyp7Okt3LC0JaZ8ddyK0ZF3OKFq+4VFdm7uMKpmgPPr/O5BlfrVoB5YlpRFKaOrFe2dKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHHeTSPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3717C116C6;
	Thu,  6 Nov 2025 22:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469848;
	bh=QZa8ayUfWJJS+Lqb+yeeTgCdpc71cKgH26tuKpF5vVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hHHeTSPGnk7COxcYQ8FvY7+BTzTZ85BAVBEH9zVPMhAiT9W6xmFQnWNVNrXJklz5j
	 Q7WTGt9/7J/45j7CCEuf6CeE5535zgh05A9vwNT7RrY4xffxVcwE/YQmanlLaY1UfD
	 K7KZdi+mWukMovxupGxst5trFxO0vkECx/iF/7fxJ4+wBQog/lC1lXLf6ucJzHBXn1
	 ZRsp8Pmz4Sx8KgVKbvFZ2R+OpP+lR3nsI2Ufar3ILpsa2OhaNMjfu8l/Sou2IW/DPN
	 xtEFlyVQEhIJpEfNAa10m3sdtXpBDJTJ8SsPGNIef9400brqq6CR3ZeyOtCVe+czrC
	 EqrTYyn/H4t/A==
Date: Thu, 06 Nov 2025 12:57:26 -1000
Message-ID: <3178ef492baf89f45a6455b111b2b009@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 cgroup/for-6.19] cgroup: Fix sleeping from invalid context warning on PREEMPT_RT
In-Reply-To: <99e1ba732f01b0082d48c6466aea214e@kernel.org>
References: <99e1ba732f01b0082d48c6466aea214e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19.

Thanks.
--
tejun

