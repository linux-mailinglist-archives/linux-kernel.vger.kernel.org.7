Return-Path: <linux-kernel+bounces-804488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB4B477BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 23:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4E45A145F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F129BD90;
	Sat,  6 Sep 2025 21:45:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828042C11F1;
	Sat,  6 Sep 2025 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195112; cv=none; b=pqpRAwS8dV8BYf7McKQk5aeCYAIS8ItAfot3rp6LRTkzDvjJuDiJqjrdawF4gkk483+oJbMAW8b5mziexDUtoNTTFRb2bXN+VMxwdckhm63Y6uYphjqwWaPF134AJ0uXSFih4/ANY3/Iu42aXAC4CpecEMW1jXE8wi3Szl7tWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195112; c=relaxed/simple;
	bh=bhMIE6MSZqFNo1JsDbth9BZC3YvbClPalVRDfH8OFiY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l8AkXLKocAvi5Z94ZeEz6FqoFp0CmhqMvsR9Kn+HTD7xJiiDbmj6J9zceyX0/T4xwWMzC8gDDTfasukOBAR7+CZCrXu1N7Aw8MgLjVAYHuzj2sIMK0VZet81CN/JDWeBCtauWWGq44xRoTbNQ8WTCoTJ5cMYP8tS+hfb+RbIICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1060C4CEE7;
	Sat,  6 Sep 2025 21:45:11 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D49F4180B44; Sat, 06 Sep 2025 23:45:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Tobias Schrammm <t.schramm@manjaro.org>, 
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250814143654.289715-1-rongqianfeng@vivo.com>
References: <20250814143654.289715-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] power: supply: use max() to improve code
Message-Id: <175719510786.45380.16502433728208652784.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 23:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 14 Aug 2025 22:36:53 +0800, Qianfeng Rong wrote:
> Use max() to reduce the code in cw_battery_get_property() and improve
> its readability.
> 
> 

Applied, thanks!

[1/1] power: supply: use max() to improve code
      commit: d48d4e4f141b38944da3b0a9c21ce6828ec31d83

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


