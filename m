Return-Path: <linux-kernel+bounces-763280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2216AB212AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E5264E1956
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F52C21C7;
	Mon, 11 Aug 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RHPyOIB9"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BAF2475F7;
	Mon, 11 Aug 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931507; cv=none; b=bTBnU4yfQzLp9HnTPAjZtklHmUqCEU5BRYVIVqgqbSMwWA8OmlA6LBEr7MpN4MqCEJkZcsULxH2ZRencRJFa2N+eCiDLgxk4QJ5eUf2RafQYjillwWEhh/X+bVN6PeJMRwFH0BWRjvOryl/Mtw/7ba4PvDpvkisCvDX6IYx6uus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931507; c=relaxed/simple;
	bh=s8sJQCvJnnwhwG/zK25BcN86IJQZukvadbAUwCn4JiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZjpWi4PfBG3rdWMi771167U+LHEllNbXPJTCbO4p3xV0icJh8+Ruj0Lwh2AtcGNMigHYiDtFsgdlHmGUOnRrVgWWVMLj740fen1L+IM+pgVzFr1qIHizIymAXnee63x6CFHP7v8dE8cC3Oil9WT+JKsgyhpnyRwcJFZPUzFYAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RHPyOIB9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 00AC540AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754931505; bh=s8sJQCvJnnwhwG/zK25BcN86IJQZukvadbAUwCn4JiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RHPyOIB97o9zYE5zgKAjwERhjV0FIYvKDiU/P7cvnOyo9CD2kM9GxUAhWC5M7VXsv
	 9Otu4nZn5gRaq2Ease72iQNBk5jJELcxrWI0iXnL44OD5E/3msEpoA3JMfbFyus+Sk
	 nFzrwNn1wRt5esNzffpaVmKnTTq9P2HS2O+dT4q6XqScFs3HFzXxQ8CTR0eQixbFuv
	 vrWc4nyREql25hI/YxZ09S9N6qkqmJzhhPtqRNdt/+3WYxS39UHVOS7GoKCS2Uwra4
	 KyNSMf3m4Tog50bYfNkRJhKp4D8m5gdDjCr1Ol+zIxKYfqCQzuJuRyxxaAnbFpiWU/
	 dIY6jMJcaf6gA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 00AC540AD2;
	Mon, 11 Aug 2025 16:58:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
 workflows@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Better handle and document Python needs for
 Kernel build
In-Reply-To: <cover.1753806485.git.mchehab+huawei@kernel.org>
References: <cover.1753806485.git.mchehab+huawei@kernel.org>
Date: Mon, 11 Aug 2025 10:58:24 -0600
Message-ID: <87pld1eqxb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> It follows the second version of this small series. It contains
> missing patches from the python backward-compatibility series.

Applied, thanks.

jon

