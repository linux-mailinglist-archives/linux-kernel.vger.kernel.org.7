Return-Path: <linux-kernel+bounces-874173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82EC15ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2AD1B239E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D317345745;
	Tue, 28 Oct 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pm2SvWPc"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D13451C1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667166; cv=none; b=oKs6wy9uI34VXn36cwZfqh1hK2oDxpGgPOeQI4z/hylC1pGDACQwrqelssF6Y8XafC/7r/mmZNT+chTnazXL4EwFXtRlFuHAQrnhrayBDUUXkm02gZyqVP0GAC/++Lbbixcs5HNxQtB9yRSsbnb9slFGnRA+Kt9mydmkhAiEUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667166; c=relaxed/simple;
	bh=TdAeWmWp64tzv+5G+Wy4ZmMKxpD9+dtoOSjNZTwKaW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kxtEyN98xnW75pKqowR94lIUUOQLQ+TN6yVGSJqKx11yBQWzwPVLd1kCLCJu46NwIWzrbMnCfIziYfg7LeC/T8ugwBPrqZs/XB+/480BU2AN6jyVu2CodJHUY6x/lhgqA1tOJ4b+BqcsuFh+4ydq1GAElYy8QNKrfsWukzsiNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pm2SvWPc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 26CF11A170A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:59:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ECFEE606AB;
	Tue, 28 Oct 2025 15:59:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7328C117A998A;
	Tue, 28 Oct 2025 16:59:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761667153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RY/nm5aUJouQ5oq2RwHqt7r9HFxM9I/z9HF1k9kOPGY=;
	b=pm2SvWPc39T2ZbKJrGI3WI0vbu7ANWhzIBOBIUdnNjhL6yMoG/7FuWLRTHcQS+DTW5QFCq
	PUm0ODvPmVckU4a+8aYXKp7Y8K54Wmb7j1zEibAMh1H/UzsQIC7MCHMhSG7fXh9wBzzNMQ
	ez4DllNMb2Ea5ZLann37cQUpKZCm2TA849XnT2X+x2FdXs2/vum33Nf771vrq4z7fM8U3m
	B+PAduiazp6/HCEuLdADctjkTaGd74Q59NtDlMp54OvNK7eg7I4aADffmsMxa5wjWPFjZD
	kHzD/tBufb6HVKuhNYnKgiCpufEMlU0Qm6qlaBJyarDVNfM1Cb6UqDAAAbbl/A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251024001943.29557-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20251024001943.29557-1-aryan.srivastava@alliedtelesis.co.nz>
Subject: Re: [PATCH v0 0/2] mtd: nand: allow unconventional NAND layouts
Message-Id: <176166714319.365556.6997921902455862428.b4-ty@bootlin.com>
Date: Tue, 28 Oct 2025 16:59:03 +0100
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

On Fri, 24 Oct 2025 13:19:40 +1300, Aryan Srivastava wrote:
> Currently validity checks in nand_scan_tail only allow NAND layouts with
> evenly sized chunks. This results in controllers which use
> unconventional layouts to fail these checks. To pass these checks
> the marvell_nand driver would incorrectly read pages (leaving out the
> unevenly sized chunk).
> 
> Relax this check and remove the change which modifies the layouts
> resulting in errounous read/writes.
> 
> [...]

Applied to nand/next, thanks!

[1/2] Revert "mtd: rawnand: marvell: fix layouts"
      commit: 6d22d96122026b62ed08d97fe585321c788913fc
[2/2] mtd: nand: relax ECC parameter validation check
      commit: 5ed7e59dd2c502b9f6850e3de69c58538cf27eff

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


