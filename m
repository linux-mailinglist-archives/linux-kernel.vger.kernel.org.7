Return-Path: <linux-kernel+bounces-896028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649EC4F846
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0EF3A82EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8C2C0288;
	Tue, 11 Nov 2025 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lydnH510"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A78283FD9;
	Tue, 11 Nov 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887429; cv=none; b=Lmo9P2j6tasEuAfvhMnqfbn7xBys179eNUzLODTIkw76gYonVjh8qpnoGi736lXIqXmpHcAEY11MJxdhhCckKsrHBpABMM0U92X25khiSqsdsLpfBPimeNN+miDxsOUNcSgrOke25xYCf1NITyEkKQ/RFDjvMgHf4VpZJFEmztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887429; c=relaxed/simple;
	bh=2U8wuJYFi4TCh0Oeb/qD/CR2N+iOmfI8LcPn8XIWdkQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UjSDWdqHdDkZAZ1XKEnzQmaI5zOWpSjulxL/ZIhly9WEaoNy9qNbX9d/6RrBd+wCsY1Dr2F15PqjcmpPnK63Wh/UJHkmAsiHZzgYHsZ0SriHU2zSujy+lHako27tW2SVXfftFWUnkSUhoWaGolli0OBpRBzk9cacgdZhdfAKXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lydnH510; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9B9C19425;
	Tue, 11 Nov 2025 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762887427;
	bh=2U8wuJYFi4TCh0Oeb/qD/CR2N+iOmfI8LcPn8XIWdkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lydnH510LhaUyPz8Dp3ej+Uv2J2zrOjJ2j0xt4AlnRnwEgjUnESblCelEo4Sh+Zi7
	 ntUEaOtcNDlv9C99BMz2Etp/yEBUpnxhjREfUtT7IMDGrZmnCFBC6ZygfKD2a2YXTU
	 gKh4WM4u1RxxHu4LzQ4jSwgDvPUDWDCAOZZqnOSgXXqjSkRM/92Y6A84Cxb0CAlVB3
	 +P+sTH1ZYhePpq39VieNU+xAnBySC1tyEHmJAOBHwa0BNFdqbsX429JvBhUusVmvFV
	 p8/kpAdh/yXyPiyKQr/rYobLWFm7znYxSRgPUbh5OO/0IjsjhYQvU+N+nPVgIwAoZ+
	 //iDPvqWZWpmA==
Date: Tue, 11 Nov 2025 08:57:06 -1000
Message-ID: <f159fcdc4464a4bee8994784cdf16c5b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Calvin Owens <calvin@wbinvd.org>, bigeasy@linutronix.de, dschatzberg@meta.com, peterz@infradead.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] cgroup: include missing header for struct irq_work
In-Reply-To: <20251111170145.106356-1-spasswolf@web.de>
References: <20251111170145.106356-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19.

Thanks.

--
tejun

