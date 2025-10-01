Return-Path: <linux-kernel+bounces-839154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CE1BB0EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB71C3206FF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90230BB9B;
	Wed,  1 Oct 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="Bx4RuKzv"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E997309EFF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330733; cv=none; b=aFL3m6tsbFin19JOxyqRZHPUNfbDidiuex0xIEIq/3iof09WTLs0TbwVibMzfmrTRY39Vg+7qvXGLpbdwTI6kDSBHRAb02PUsnUdAPUYegm5BjL0pWkZj3xmDH82ewrps5HjNUEquH0OHNcNMtaEyksyf9zUrxKdUiKPw9U1qCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330733; c=relaxed/simple;
	bh=cfs3RMdFUWhRa3v6YClzoxB0PKItJFrZaTuLXzdfSlA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=NdcDPPnYh9WGDRAXPeT5LsAqgkZCJoiP6hOD87jwtivWsBJsZk3p+OAocfQvjinXXMveBCztqk7kdT8F1cvEmjj0axrYXyUKinacBZSLrflyQA/xju2ub9dpWN0qwyl4sN/QfbZ2Yet4YrREPZ8XiS6QwEvzksN7mcljRd9Nx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=Bx4RuKzv; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=svUvpbaXHVsDBpvT+GLck3mR9b5ye9UtD43InOr03KI=; b=Bx4RuKzvFfrJrqtXo7YWB5zAy0
	wQfjs8Af0PQqZlxDuDUAwUXeNOtJtV+4VLBswqbcGzpdsV3i/gJQTWMOYYhtmc4Ua+fNFEFEdIkjI
	CyHGJbeS10nrSj6LjUfsNebM7GnPjBzmKWgxyU5Pgrv5TsA14rDcYgEICxlHvNmVOiITDWLvBR7Eo
	H2fjkfsr0xzJaaSRltTffIFv7k/WOefMmz4/RthK30pnP6/29aiYQZltAlOCDR25ABfBMS8oBADgl
	WQe9C4hpt9Xxsc17nFkYhRNxJG5+IhvXu+8CQNla9nelAM5F7u+wTsBBpWw5TdB4DkbnP0Aa0E1EX
	AkizCbJQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1v3yHz-006O1X-O4
	for linux-kernel@vger.kernel.org;
	Wed, 01 Oct 2025 16:58:43 +0200
Message-ID: <372642ea-7513-4d68-9965-e7055a6c3493@bitology.eu>
Date: Wed, 1 Oct 2025 16:58:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bitology.eu>
Subject: Consolidated under Bit (was Unification in Bitstream System, Fair Pay
 Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Consolidating: 𝘉𝘪𝘵𝘴𝘵𝘳𝘦𝘢𝘮𝘴 𝘚𝘺𝘴𝘵𝘦𝘮 𝘗𝘩𝘪𝘭𝘰𝘴𝘰𝘱𝘩𝘺, 
𝘉𝘪𝘵𝘴𝘵𝘢𝘳, 𝘉𝘪𝘵 𝘍𝘢𝘪𝘳 𝘗𝘢𝘺 𝘐𝘤𝘰𝘯, 𝘉𝘪𝘵 𝘞𝘢𝘷𝘦𝘭𝘦𝘵.

Updated: https://www.youtube.com/@Budi_Bit_Hackers

Story in Playlists: https://www.youtube.com/@Budi_Bit_Hackers/playlists

Budi Ywe Cærlyn.
https://bitology.eu/


