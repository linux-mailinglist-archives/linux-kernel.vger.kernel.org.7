Return-Path: <linux-kernel+bounces-797335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15C9B40EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826891B6527C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842BF2BEFEB;
	Tue,  2 Sep 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="m6BSvvyi"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07923568E3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756846976; cv=none; b=JdqpA4HUsr9oYov2vEgW3QCREtZ1BFHqSV7O54NoPK0/fGFOBG/d3rpcwpDa1GU71WDEKEG1fwQEAwI8P1e4AhYw/kA8m2PvRaWbhFtDtTw325N5kpZj1d5QtbJOYPzwNqrV7VdASds2sLMdQgQcRbXCnCo83Bi/1IxQO7sa4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756846976; c=relaxed/simple;
	bh=vO3NA/+ebTeYyGIM6crQ5SwhKSUaPcSo75mb0j5t9BI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oCEJ5oLFqvvQgqDjbxTy8hX0SLcJ3Yk+HSanFHZlRqjo6BZVRfqsCz5hE6PwKS7qsDvh8J2AufGPHGgJHoyQJOc+NTB540fDgbbSLUKuf5kS/8tOyJDgIhTyvTCsDgfvn4tGvB6OX4jrl1QxkVfH7oMwUylzJwvqP+U5xvR5QVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=m6BSvvyi; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qDjoAW1LOLdImdX26EHxKF3hMaITNpGJYihQt/pFyks=; b=m6BSvvyijfMMrMm3JeLR4NPB+2
	pdaKI10rrRXlj3cQ7YCHJjLI7XHqh0jyPfPBiQZRh2akEG5HUQWsLhKQdObF0jA/1w3O6jr1KDD3f
	Z0XFY5xu7qV6H4tdxBiCCN5gyM7Ut/lc8n35Lx5h7+rmK2BUfHI7vMzcFRJS6doAw/naFb9yX/5OH
	GojUl9QYbk8RY5Y6S2dLKogYkM8o9l4Yj2NMmWNWCDJwrqA1JRZtXF3D/DgJAmFb2DX+WO4zODrq1
	jBiwKsHsqZj0p14U4uqgfvo8ev5z1/IS+MzhP225dkVut4nTjhPRu/v1AtFErfikSGMgYlc1mI8Gq
	4zVA/gtw==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1utY9T-00B1PY-Jy
	for linux-kernel@vger.kernel.org;
	Tue, 02 Sep 2025 23:02:51 +0200
Message-ID: <b7ba73df-438d-4eba-9466-0be8306b8e69@bitology.eu>
Date: Tue, 2 Sep 2025 23:02:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <itx-budi@bitology.eu>
Subject: ITX, Kawai Bit Icon = Finalized Referance Concept (was Fair Pay
 Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

ITX and the Kawai Computer Bit icon is now a finalized referance design 
concept, which I hope the IT industry can unite in, and be strengthened 
by, all fair pay politics respected.

Recap: 	200uS os-jitter target.
	72.7hz refresh minimal psychovisual noise 4K standard res.
	J language (a native remix of C) for optimal use of buses.
	Fair Pay philosophy, with basis in Eln, and Islam
		(fully supports Obes as prayerhouses)
	3d printing, including indie clothes making ++
	Contributing my own AI wavelet aswell (perfect Q norm..)
	Possibly more coffee.. :)

Use.

LIGHT!
Ywe Cærlyn
ITX Budi.
https://bitology.eu/




