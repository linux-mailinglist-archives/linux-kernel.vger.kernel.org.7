Return-Path: <linux-kernel+bounces-785611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7F1B34E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158A01B22870
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA629D297;
	Mon, 25 Aug 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b="n8vL8vab"
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EEAD4B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158986; cv=none; b=hS57jXSY9VYskVEEvh+MuxtD01Vq5/VVPO0uG7fI9QTZAoJF/onSsE0dNagw58ujwi+7yR84Dm/vrI8LS/Z1lum29mAH4sK4/Do7s6jlbIU7CStQBgqdpqEdohKk3SUvTtlXGcQbjlCRSYhGnqR7jMYafjRmsknb22ybZC3tiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158986; c=relaxed/simple;
	bh=hWJIO2sws/xStZhhfgrVZZx6ZEda2KaT4k2a8/ohfp8=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=u3LhmvgI7qO7HJWmMRwpw/3ZvYQU4usYBOz9OXXt8P82NG2/b30S0PVyEcWkEAXq6nVLojzWjfYdTle8b6TEstI4zjzmlrGncJVro9srKbaS3bXNiqi14poEO9ri1sIRaqo65i7LS7QcBb6WVCdg6hTcgUlmbcA6I1yNsqHpmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b=n8vL8vab; arc=none smtp.client-ip=210.65.1.144
Received: from cmsr1.hinet.net ([10.199.216.80])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 57PLuLuB595442
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:56:22 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=msa.hinet.net;
	s=default; t=1756158982; bh=q2zIQ6Xs/MiAhflU3xx/I4yghck=;
	h=From:To:Subject:Date;
	b=n8vL8vabwNAfJ41Nfb4WIXOIPxcqxZkngMQQrBtDXzv77vBSW+cPuBCu9A4qKmKrs
	 FFMmXzOT7dO+1zdCdhzqO4RO8j4ecNi9mHrr5UJLA5QSz6Q+SqsV2UA9Nn5uIM0jwY
	 aYyVFrL83vjEsV06s8Yy7SIsUF+jhTryuOQpfb7w=
Received: from [127.0.0.1] (125-230-93-12.dynamic-ip.hinet.net [125.230.93.12])
	by cmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 57PLonbJ950664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:50:52 +0800
Message-ID: <93c83b61f437dbb092eb21672d8e8c45cc36ffc0199665b3cf133208964b8b21@msa.hinet.net>
From: Procurement <europe-salesbond@msa.hinet.net>
Reply-To: europe-sales@albinayah-group.com
To: linux-kernel@vger.kernel.org
Subject: September Order - RFQ
Date: Mon, 25 Aug 2025 14:50:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=YdAe5BRf c=1 sm=1 tr=0 ts=68acdabd
	a=cyYSZy7PZGD5hGPOogbXNw==:117 a=kj9zAlcOel0A:10 a=woOiZ7w2AAAA:8
	a=Gp9z5yGasSGPIeDKQg4A:9 a=CjuIK1q_8ugA:10 a=y8FzcybzHWbWVUxH3U7b:22

Hi,

Please kindly quote best price for your following products:

Include:
1.Price
2.Delivery term
3.Quote expiry : September

Thanks!

Kamal Prasad

Manager

Albinayah.com

