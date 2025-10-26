Return-Path: <linux-kernel+bounces-870265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD2BC0A524
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801243ADE72
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD0288C25;
	Sun, 26 Oct 2025 09:03:06 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198A611E;
	Sun, 26 Oct 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761469385; cv=none; b=iCgQ25FXWgL3gS5GiMSvgderSBtDsl9jO7xh6MAg9Qo1XIhsak6tTsXA+6WsXVy0H0ULyghToars9VeXoc+hU1qrcPfv8TvftHVuvmJu8VYmkKgANXTqToycF/w7hkrRK5iz4jVZieOjFDUz0mfyH2orFP/0o77u03cMARwOIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761469385; c=relaxed/simple;
	bh=mE+oC5AupLSk0QKiZ3gvwBoqI56AdzoHcuair5Y5DpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anSUkh6Ut86rjwkEj3L1bc7DcQUwUbDdIB3m8hJz/a1TwJ/89BawG85mBPJNrtqZnu1gj8nydYL8cVFfL/I8WBNG1HUokkeXSauMe5XFvivoZNC1zOoB3c1woxLlVpOxRloYobz20TsXTQNDnTjp9EEx8J0Qi7b1TyiXJ9ZR6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 64E222C000AC;
	Sun, 26 Oct 2025 10:02:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3E3964A12; Sun, 26 Oct 2025 10:02:53 +0100 (CET)
Date: Sun, 26 Oct 2025 10:02:53 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] keys: Annotate struct asymmetric_key_id with __counted_by
Message-ID: <aP3jvbe3gfDucycd@wunner.de>
References: <20251023174810.75805-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023174810.75805-2-thorsten.blum@linux.dev>

On Thu, Oct 23, 2025 at 07:48:11PM +0200, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

