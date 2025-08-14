Return-Path: <linux-kernel+bounces-769098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516EDB26A36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6838DA26E46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1078F2139B5;
	Thu, 14 Aug 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nPxhG2u5"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6A210F65
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182969; cv=none; b=pxqSkaAJCoCHy+rs13emhU/DWGlVGHB6/IU1DqqaQKQyiWsi9QBary3e98BB2xamxhX6LNbFiYtTyYd8nO+ikLj7EA4iIbK5amaCNzppelDZ0fJa9UP1jrHPtxlFmdMm92ZgisEwFHZ527U/F7A8pmOBvOWNM3G/Z1CT+46gKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182969; c=relaxed/simple;
	bh=xA7bY5MGLleOxCnwoJjizzyup1kl4YBeDF9jYxohzt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7dHmDNIkU16h2JwPhkKcj8YziXNVIcYSwMuAkaVXalHmBDDWePE0Fs6tHft63x1nVGjZoO+/SpST6HUPEzqOt1l57NDYvMjlqPXbhndivX5T7kdjQu3S92hJyre7QvjS1p4w/eQQhC0POCXLNvmadHGX9uEcfmXud9YnWaPYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nPxhG2u5; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmp8b028581
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182933; bh=I79rDI49eWfu28BpIHJrn73gMqpZKVaoe9bAX/3m93Q=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=nPxhG2u5wwsDNHAgAE5S79TUt6yA6MnG13IJH4WMYAfzM1CevmZJTyV9i2NxyUWMX
	 ubAnaYnc2aJERLR1izu9MWOZ838FoOycho9yT4jCgp7jW4Ac4gHfWfE7wwueWofojG
	 ccXMYExFT6Uho8jpRrICv2KG0Zylkr0Em2g4Q1CFHhmedbw+v7APB7pw+m4D+AsjrN
	 yhwmTQpoQmfEW5b6JZnBqEOJFSPbnO4CA+BfpPC5JYlqRdJ16xxG9yDoic6amHY8SO
	 7Z5JJnw5+MbwNGfC7GlC1xQNARjlbYpElPi6UVyxTGqOxawaQL15i8+YWOGOAut4aa
	 mQEXspRQAGRqA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D107F2E00DC; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        adilger.kernel@dilger.ca, Baolin Liu <liubaolin12138@163.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] ext4: fix incorrect function name in comment
Date: Thu, 14 Aug 2025 10:48:44 -0400
Message-ID: <175518289078.1126827.6171993423494924880.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812021709.1120716-1-liubaolin12138@163.com>
References: <20250812021709.1120716-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 12 Aug 2025 10:17:09 +0800, Baolin Liu wrote:
> The comment mentions block_write_begin(), but the actual function
> called is ext4_block_write_begin().
> Fix the comment to match the real function name.
> 
> 

Applied, thanks!

[1/1] ext4: fix incorrect function name in comment
      commit: 757fc66da91b54d4fbc414bee5c440b52560d3b7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

