Return-Path: <linux-kernel+bounces-842925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52994BBDFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885403A936F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417427B347;
	Mon,  6 Oct 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQbWQ5AR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C727AC35;
	Mon,  6 Oct 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752785; cv=none; b=dpSHmmOH3ppQ5w2IdK4dLVfUGj2AGk3VB/tsHedM6XdrThp6RUiiDsoQ6sBC3MRF3FzDVwaXlMXHLv6EBR60Ek9I0lKO3N53t15o96X+Vb0dc9sdeHGIBPCdVOT4ApKQkTLQMygIYviszwVH7spdk37lFX0LhwAg2BONlwL/BKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752785; c=relaxed/simple;
	bh=p3IKQuHS+gb1KWVqgh9orY2OdGeGJudQIKMRbQSjwms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClqNc90p0snOn4JqBVCo11rlmJBG+7HQVojA2DnxiJdNt1NbEbQBA0efaBCdiWyjY4zNFpcAw8d1ckv5zByOtFC5jUyrePgS18W0Wm/F0X9QK69c2hKndMDAx14fw6z/jlBUiGbUvU2DlnaKJhrn5CS79yCMYaiDSlJSOXsNXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQbWQ5AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0618C4CEF5;
	Mon,  6 Oct 2025 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759752784;
	bh=p3IKQuHS+gb1KWVqgh9orY2OdGeGJudQIKMRbQSjwms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQbWQ5ARoC5MYKrvgiE8G45TdEq9HoelDQoNrniDTVNPgMYKPzePPLSEgj2rzTTqa
	 +eW/EV/G4abJ+RHK9es8k+3X3DpGDS+a73YGPstGqjtS3WeR+t+FaXMeU0hoSu3ca9
	 5KFvuiqF6WCiSa2n+6Z3+l7U7FrZP73iV6lQNzl9nzPMKqAqLtJTSzLsptp3t7zdE3
	 guNH858L4up5Ix8vtd18qrmhFt1mObs8NN4oHBLFQQqq9HwbGkvElItr6pefAsxLiL
	 mIwifYVWz8+pbey0smzq+knQkiPha9jg5mIDKlcplyXwI9B42WZsQYgwtRrnpsEO+P
	 DoCZBzs9hycLQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v5k5O-000000000hf-1fLB;
	Mon, 06 Oct 2025 14:13:02 +0200
Date: Mon, 6 Oct 2025 14:13:02 +0200
From: Johan Hovold <johan@kernel.org>
To: vivekyadav1207731111@gmail.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
Subject: Re: [PATCH] usb: serial: fix: trainling statements `break` should be
 on next line
Message-ID: <aOOyTtruyDVrzuCe@hovoldconsulting.com>
References: <20251004080123.98285-1-vivekyadav1207731111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004080123.98285-1-vivekyadav1207731111@gmail.com>

On Sat, Oct 04, 2025 at 01:31:23PM +0530, vivekyadav1207731111@gmail.com wrote:
> From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> 
> Run `checkpatch.pl` script on path `drivers/usb/serial/*`

Same here, don't do that.

Johan

