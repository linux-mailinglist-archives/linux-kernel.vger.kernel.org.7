Return-Path: <linux-kernel+bounces-731708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D23FB0587B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104471A62A58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD772D94A0;
	Tue, 15 Jul 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jsqW+LHd"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55382D63F4;
	Tue, 15 Jul 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577745; cv=none; b=n6JOaaS2mxAv63ZQ+OR+VZj7HVueBiWHQQix4gALTrD5+y5dvF7uY77EkuvZCoV4DtiKqX8Sa5Qd3L84oqpU0Z5fZMs5DZTMp6hFxNEH98Um0UI8kp+Oxqx+JUAsHNYkI4zg8QzYikY0FN20bPML9xz/itIxAcZ2EB+tfjq5V94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577745; c=relaxed/simple;
	bh=HydFslMeX91JsVbfma80rQddqq0IbAYFGVjA2Ap1ovY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKLzsvkQmel1TZ3P4ZENhz60nBuLG6LsbMMJ84gnHjvKFyZlZXne9QV+ikqNKJwBlvOj0mvm59GOxS7qh7QveNkvVZZjj9y0HFsf5txyItjt0FiZ9/77fC7je1ph/XUFh6Uue91pp/9mBPfOTCHm3dVTenjar5iWjdWz3PHunjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jsqW+LHd; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=QCkYUzgDxAkXibDkggPAvcI6Vv/4f0QuIfu4aUOzukQ=; b=jsqW+LHduzFR06/yIXBowzjeHR
	4BiEPIsnvJns23YlNLRNk5uKsJdRchI+f3cxp3XxU3K1VYqZAPSqffxKW3LZAjxWjj/KvNQ/LVDCz
	itWo1HKkSq+6pQ7ccPqFlkq6G4G0S4onLDQ/xtGy0pfvsHDqfdtEqQbbmNJmqtRp09sWH7n2OHC+w
	MzDfFHFY7y1O2yK8F/Kdlvkkj686HCAc1a+qXJuieq0dhGPbQU88BiqYIm7d6lPgq4sMcqXTec4u0
	13WYfULL9kz29TdCQbl0i6ttaHQTf0B/wiBAgybVbkWXfnUV0kSbAUrCA/HKWGemYRn5R6PVRCG2x
	/Pn+3JDg==;
Received: from [194.95.143.137] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubdWq-0000O7-Sf; Tue, 15 Jul 2025 13:08:56 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add reset button to NanoPi R5S
Date: Tue, 15 Jul 2025 13:08:45 +0200
Message-ID: <175257771276.2527819.12482160462723164616.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250711142138.197445-1-didi.debian@cknow.org>
References: <20250711142138.197445-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 11 Jul 2025 16:20:37 +0200, Diederik de Haas wrote:
> The NanoPi R5S LTS version has a reset button, which is connected via
> GPIO. Note that the non-LTS version does not have the reset button and
> therefore on page 19 of the schematic version 2204 it is marked 'NC',
> but it is connected on the LTS version.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add reset button to NanoPi R5S
      commit: 954f07012794a3aa7ae89e56f070eaa1643af50b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

