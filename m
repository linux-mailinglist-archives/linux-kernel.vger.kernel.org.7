Return-Path: <linux-kernel+bounces-874172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6922C15AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD3E3B75D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E803451D1;
	Tue, 28 Oct 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TY8rRApu"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F234402B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667165; cv=none; b=IQMj6C6ultstt71hMVxPmda6TutfF8e6DwKwU2rh1LkCB8i6QazFPRtttpozoeZmg0c4sZaqymwpwtHtjMDxg9pTaV7q6HHCxu1U0S83YQg+L93HRW8nGcA72OQ3UT5LQ3+rLhCpuUho3vkgr8FZ6aAdSmuUkkHwT5nP3WKGAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667165; c=relaxed/simple;
	bh=RTLGSpjrQ1ImABJfi/VAQfh3gN0Itfqt2aNCceR5h8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kuxEmmNfjOnI5rSAEgGcHxXuMtWixnRS4+1yRTRkPYajuchoCNAyYhOAe0yDkkcmiymvi7mVFPl+LzeIHdY/RLUbr25PUek1CqFl9/aJ+4CCruSZoKU1aA3tyyFSDe1tqmxhYobbTguIAK2cxkhG9nSR1gmpqAUSFFao7xkC+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TY8rRApu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E98E41A170C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:59:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BF148606AB;
	Tue, 28 Oct 2025 15:59:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BFF6117A99F8;
	Tue, 28 Oct 2025 16:59:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761667159; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hAFtFEMN41KVDleG5UTxtREAtjcFkU9gQ7IFFJPq7GY=;
	b=TY8rRApu9XyAlv1PMITVi0UFV6D74qU7dbiVcL5W82XtKibRtJ9Xijy2h6JcekgfZ6c/Qi
	rBCk45x9CtUheThYRc4WT3Gwodu2Z0dyvmaM0zPY5q2kW8KnAQuk8KcgyQ89aFFxeyMJkF
	3fVDlq4d9s6izO+HRJOql6wXeS+yBBspzLAcA8lSvFDMxU0Ks345UxPKETiMDYgf5zF4N9
	9+E6boojg2sRQo6cxDxEEEz2vCH37b6R/Jsi7F92Zvov4TEkHUSS0ilF8b82DmM1+WwQ3h
	UhocztOewUVZ1ZrtDWThAT22bP1xixJL0abOeOKeudEqjWZrmZWg/SItBSgFDg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, niravkumarlaxmidas.rabara@altera.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251027102304.658490-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251027102304.658490-1-niravkumarlaxmidas.rabara@altera.com>
Subject: Re: [PATCH v3] mtd: rawnand: cadence: Add support for NV-DDR
 interface mode
Message-Id: <176166715382.365556.10326674698031952686.b4-ty@bootlin.com>
Date: Tue, 28 Oct 2025 16:59:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 27 Oct 2025 18:23:04 +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> Add support for NV-DDR mode in the Cadence NAND controller driver.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: cadence: Add support for NV-DDR interface mode
      commit: 573df859aa087cfa38b1a085e4d486de8fbce989

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


