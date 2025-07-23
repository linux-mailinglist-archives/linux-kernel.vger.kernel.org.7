Return-Path: <linux-kernel+bounces-742217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646CB0EECD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2EA1C28176
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C35289809;
	Wed, 23 Jul 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkV6vMS6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932F286881;
	Wed, 23 Jul 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264357; cv=none; b=u4oZDwUAEy1vEG2EPEBuYopXTSYygBtw7/y6riWjhfJhuYfQEz9T3V/kUi/HL/I9Pt0Q9sQjAKXgaMNv4DENQ5MlwqCfC+WvYecoSt1O3k7tL6FOQ/8jnh6ECJAvHn681Mlth7P0wy0nFyrQq5nxBeYdQKlNsAnLi45nOY2SpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264357; c=relaxed/simple;
	bh=+wQKGYJ8E5igUxnQNQhVSMViz6MZKDL8iigyUEy9eXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IM5VRmWZ/jm+3HN1dr+Hlze+vovVIMz5BdXkhSC71JLSLZKiTIaXcRR88vXoZddzDq+CInI/jOtBa5lQ6tmtTbz2xfbawRoUP8NfQOd/M6G2+Dofl3OE9PbwVjsP/R1+CukHWSDXo/ijQnkqY5lyPZ6lYK6lfydMe4KKcdNTL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkV6vMS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAEDC4CEE7;
	Wed, 23 Jul 2025 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753264356;
	bh=+wQKGYJ8E5igUxnQNQhVSMViz6MZKDL8iigyUEy9eXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GkV6vMS6cYZOlonHCDPQFwBpyiNY/JTwK0KReAiIYI0bHZLvWNS3QWY1dJinmMA4+
	 pjJ2sJsaFAwx/nxQQT6+/l0CcYmfC+FI485pjmdREnmAJGWiMwU41vzYocC9YdNTZR
	 mR73g3ey4J4wr0RkvFhRwTZDpJYH055u+GqDzk6ByTpnd1SI3iKtmgwyHMP7A+AULn
	 O9BrzDUJrE1+1f5YSWp6T2r9+K0C/toutqsFOYaVZ+0lL8IXwnczk2kD40EIxVpOwJ
	 7pM0lcJlXUplvSpRNPyansy2hFAAB0CAI+Fq16QZlnxc2T6PM+pz1y0GRLE8vbdTBj
	 HugNdEVlDXXqg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: praneeth@ti.com, m-leonard@ti.com, rklein@nvidia.com, jm@ti.com, 
 khilman@baylibre.com, kory.maincent@bootlin.com, 
 thomas.petazzoni@bootlin.com
In-Reply-To: <20250708210448.56384-1-s-ramamoorthy@ti.com>
References: <20250708210448.56384-1-s-ramamoorthy@ti.com>
Subject: Re: (subset) [PATCH v2] mfd: dt-bindings: Convert TPS65910 to DT
 schema
Message-Id: <175326435403.1737056.64583377188739989.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 10:52:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 08 Jul 2025 16:04:48 -0500, Shree Ramamoorthy wrote:
> Convert the TI TPS65910 documentation to DT schema format.
> 
> Fix incorrect I2C address in example: should be 0x2d.
> 
> TPS65910 datasheet: https://www.ti.com/lit/gpn/tps65910
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: dt-bindings: Convert TPS65910 to DT schema
      commit: 22c7481c4052bc7ee0a81bca2323f4cc7abba17f

--
Lee Jones [李琼斯]


