Return-Path: <linux-kernel+bounces-762699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC69BB209F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4943AC5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4772DAFAE;
	Mon, 11 Aug 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="KPQQCul0"
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5935220F35
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918529; cv=none; b=LFDtA8TySKpBj8Vmybukgqbgzq37oyC/qzMRJ+3dRfdVO9VVSLOSpLMWNjQ9rYQqBTd2IZwW9QxONFcmcOL/AAXPsv3Qh/aSWPkRLffPvXjl0rLP2m3DwmMD/KBfGPeHwiNkb+R/D+rNL8V++8WJHpUmvuJL/gpMCtsn2JUT1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918529; c=relaxed/simple;
	bh=CfpxUiHBdhu2G6Ba7HFsEFU/rymlqX4utjgUVBB7ly4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DoxrvrY5zIvyl5bD0/YuWGJz2Xu3XfJFr57Zesb9H8O7JQNNn3gaf/EQ6xzb6K4dbBgvIYfHxD+Oe2e6RJ27PabQcTmeqYxMs2lFtk+g8DHFiQWl95ugqFolWCbub6TeNDFj5K7y56w3sEh8mNaRH/zR5AI0xGhVlSeoupbxJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=KPQQCul0; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
From: Eric Hagberg <ehagberg@janestreet.com>
To: christoph.boehmwalder@linbit.com
Cc: axboe@kernel.dk,
 	drbd-dev@lists.linbit.com,
 	lars.ellenberg@linbit.com,
 	linux-block@vger.kernel.org,
 	linux-kernel@vger.kernel.org,
 	philipp.reisner@linbit.com,
 	Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH] drbd: Remove the open-coded page pool
Date: Mon, 11 Aug 2025 09:16:02 -0400
Message-Id: <20250811131602.978555-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
References: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1754918170;
  bh=CfpxUiHBdhu2G6Ba7HFsEFU/rymlqX4utjgUVBB7ly4=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=KPQQCul03cpE2v3a8J/51343S4VrnSIKOwhxPcd4nx4XdeWfOssd4cmi3OKnwKjwr
  qbITIRUC+blle55bZ2n6o38qPRlA+Z7FDybdBzOXSZHSnhuf7F2n4GxmTbuXYXFo9v
  XKq6S43UG2b8hJpTeDfF/oUKGB7vvXfwrKEpIiIkdiXMe7jBNBBQIvwRlbf4EOJTIG
  Wo/8zx7mVhKNmOEaA2RXTpdPxvxY+WRbqVnbk3W29IEO0nf/gLL3qZ0G3a7jTm0iS9
  8+T9QFlQ7OsuEzQnURnQoJ+ueUUoY/GDDCqk9HGC8609FB3l4qWcKxVSdXrk60Du4O
  cbs0464r6Qp5g==

This patch has ben running on thousands of hosts here and we've not seen the memory leak that
was happening previously.

Tested-by: Eric Hagberg <ehagberg@janestreet.com>

