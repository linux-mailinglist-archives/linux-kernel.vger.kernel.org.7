Return-Path: <linux-kernel+bounces-746903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D907DB12CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 23:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827C23A6311
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8366B2222C0;
	Sat, 26 Jul 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm9Q3ge8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0021C160
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753566277; cv=none; b=XNmSstEA0ogLTgpn2SPpwPjYq1y88zSGwNCYbgrct6qBXVjlY826FCZ6lUqEuQZgyG5N4JvlKwRCek1ZbgsndRdgvS5Wd80sItHqom2pMtSCcGNtWCUeRPy1sxDS+eEkFl0QW4OdcEaInrwpLVjgin7gWRF++D5WB0SgfHetE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753566277; c=relaxed/simple;
	bh=8pKeCYuhTe0V/1hfLNncO9jrLuVtfIE60M0+Vurxh5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnmE3E0nNeZWsObaLxxHO64KR53BflPCq1uyyifb0Tixx901YNDSb1yQYgyZDId6od+6F81sjxWh8c0tn/R1FoqYcxAzcDcrTy27NfuTKtEnIrtA9dmMpdHA8el7mwwAxj/7pOIiZoT7f7Js6qzAuMpB6Uqn7uiy2ngY1egbCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm9Q3ge8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8AFC4CEED;
	Sat, 26 Jul 2025 21:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753566276;
	bh=8pKeCYuhTe0V/1hfLNncO9jrLuVtfIE60M0+Vurxh5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fm9Q3ge879pdN87lCkojCYW4D9SVOMMihGsifCblzqt31pQpeHG7h5gpNdTcV897q
	 SjAW7BnPBBNMxKwSUiDQO4rVE/Eft4sF5vOBEpw0sgAqStbk4asPtpVoYcEWhZJYrj
	 nhuTezu5CDlhWQS6Xns3TVhJBax7NzYXZgc0WvEJ0l8l7O6TNKLuIODdHWfcRC6ibb
	 LyfyfthaBbpHlFNg6kPR/xUpFx8NynocnpR9TAPGs/rt2uWCpy7SMrXEtwhkLASvdg
	 3YDWXVfEdCjmSXspGdnbON7JECvcuHNYv2MzYViRVnvecte0cftDsRuswHCQibDsDu
	 RVdL4HdkrQv7A==
Date: Sat, 26 Jul 2025 14:44:36 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] execve updates for v6.17
Message-ID: <202507261442.5B0F37DA@keescook>
References: <202507261437.F2079B3B7@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507261437.F2079B3B7@keescook>

On Sat, Jul 26, 2025 at 02:39:20PM -0700, Kees Cook wrote:
> Please pull these execve updates for v6.17.

/me bangs hood of scripting machinery

This should obviously be for v6.17-rc1 ... Let me know if you'd like a
resend with a more accurate tag name.

-- 
Kees Cook

