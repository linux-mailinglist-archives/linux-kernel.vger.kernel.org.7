Return-Path: <linux-kernel+bounces-826289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17AB8E17F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E4D189A7E2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D1262FD4;
	Sun, 21 Sep 2025 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqZqhoga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB525BEE5;
	Sun, 21 Sep 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475017; cv=none; b=I3VTAuLKyl/+uBQSoM/3HxNQLfCu0vtofVkVVxwh8tW6f7iT8AOjJPP5hBGFD06KXJGZLUd4LUxYsmPJAoHiiOJUHlg126PiRj7X5JtJHR3/j9/mJkqCVzqqDjsO41MTQAUFUaYkcxqSQBT04Q9x0y9Ux7PPQ+jml5acQBXQutc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475017; c=relaxed/simple;
	bh=5pwDxzyQEn+iBDtKyLYCmHQVSJ6/W7lkVlzqOH9eCks=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=f2pb5pyZXUZrsgfxz+oRd/B84/1Jcrz/YhDxZbnCl+sjH8d6tLGcbhC1TnZdpM0Qz40eiPhFZtjgEJpfayY36t1CWhnSBA7sXm+1RAmmAVQIhJaFRnT3Rg8xSca76R5T2qxZMKeeDB07GyAU9TRii5GhQU96LghR5KoSsv4Ln9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqZqhoga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E324CC4CEE7;
	Sun, 21 Sep 2025 17:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758475017;
	bh=5pwDxzyQEn+iBDtKyLYCmHQVSJ6/W7lkVlzqOH9eCks=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YqZqhogas/JJIGwYzK83wOMaHr8WS6DsS2UDjE4tpj3MwA6o3PFNGAjDJZI70T4F1
	 fW3TqUbO8tzfDOh8zqEWDiozw0SWdSIRd8WrneBFIaQ98B4P1rTHmxeYsmSThsT9pZ
	 EVgYn0ySCKXxySVOm/kZSt82virJ19an6cz83jQ37RNRjwA8sPBz/DeqssqFpaHcaP
	 cfy8Hbl1Io75eKm85cTeMp7ShoofPA0L9jWpQlev8YHHAT7eczaVnF12Ft5rEVlFyA
	 KQ8cNQt1jwU+oeIiAnOEZMqAAaPfkeiX6NBT9mg9jrv0Y/xtsCT+1aDyaSipujI5As
	 SD7unuHWLjsTQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250814035317.4112336-1-wenst@chromium.org>
References: <20250814035317.4112336-1-wenst@chromium.org>
Subject: Re: [PATCH v2 1/2] clk: Sort include statements
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Chen-Yu Tsai <wenst@chromium.org>
Date: Sun, 21 Sep 2025 10:16:55 -0700
Message-ID: <175847501556.4354.8718434383967720736@lazor>
User-Agent: alot/0.11

Quoting Chen-Yu Tsai (2025-08-13 20:53:15)
> The clk core has its include statements in some random order.
>=20
> Clean it up before we add more.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next

