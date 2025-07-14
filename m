Return-Path: <linux-kernel+bounces-729991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9929DB03EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9217175DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182D248872;
	Mon, 14 Jul 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="PEN9EZ0m"
Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCE247294;
	Mon, 14 Jul 2025 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496371; cv=none; b=cB86YB900ppPaO8G6hqn11tBp/rAV5k2RXuDLKmxJ5BqOQZM+NZz1oebJ5ESVwb7c6VbDPQH8x3hGoga0F2j9R9HLhS9gMtSYLa2EBsjRlD2aXo66YzsPhOfruqyX/Py0efwfVJBvqjMDH2N0deEgUONyTkyYgaJ5RL1p9B15Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496371; c=relaxed/simple;
	bh=nE94uqfkRsgkO3NvOCBnZhGFPYUB4TT58PqKmdCbsbM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:MIME-Version; b=phkkufUXR47A3YffnorZoY0BpD5mWiP2/A2sS/Yn8E16dSaUi1f+9UJ2AdMO36Ve9GE8Ey05LEudbHWZZ5c+SJMhGdWsobgMDVucr7IbNHXnZXYj9a/UGLyfEXFdO046jI8xv3skS3FVKXKybbh5tFxNe8gkGa94JNVNcPuwLc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=PEN9EZ0m; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=PEN9EZ0m;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id DD17F2444CB;
	Mon, 14 Jul 2025 14:23:31 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id MQ0dWijxmNAH; Mon, 14 Jul 2025 14:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1752495811; bh=nE94uqfkRsgkO3NvOCBnZhGFPYUB4TT58PqKmdCbsbM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=PEN9EZ0mNFpI4wliVeLDiaNw0J01iKgzvkS9o8TsilWSlBgJH1CImo5EYZ4lLsno7
	 0Xv2JQnWqkeQYiJWgZzU6BH9RgKH/SY8mIAx7PgUVbCnUGE0zZ3l1RgSM1PEyzyHxe
	 el/o5fVr1cJFt+tInAqmk4ZP2LseXx1nOtX+RXy+v/xYJLtAUmcRsxlMgW/BabCF/n
	 XaOdpjLbI5QQEzQpm1F81QjdKnMekrkxRl3PeY22zf7nSIUB+/OuWqtmXYoLhx+otW
	 Bis/rPZimcD9igv0F9NCYAKofD7F8CyXrrkXBKu7SQMnJwzxBZ9gJ2ZgS3JGnz3Qne
	 dFFEndngj3x5A==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id 222D92412EF;
	Mon, 14 Jul 2025 14:23:31 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id 02CA31601BA; Mon, 14 Jul 2025 14:23:30 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject:  Re: [PATCH] platform/x86: asus-wmi: map more keys on ExpertBook B9
From:  Anton Khirnov <anton@khirnov.net>
To:  Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:  <20250702070231.2872-1-anton@khirnov.net>
References:  <20250702070231.2872-1-anton@khirnov.net>
Date: Mon, 14 Jul 2025 14:23:30 +0200
Message-ID: <175249581097.21445.9069512593432044354@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ping, can anyone please look at this patch?

Thanks,
-- 
Anton Khirnov

