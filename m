Return-Path: <linux-kernel+bounces-578050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D35A72A27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 07:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1CB3B756A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70B1ACEB7;
	Thu, 27 Mar 2025 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URV7Mfnn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A961C28E;
	Thu, 27 Mar 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743056833; cv=none; b=EGz0slOwrwEZGj61/4PGvPpo7C8OYc/eqfR9Pk0wov9qyEoyAP+tlYKgZVRH9aZiQIhagfZ6bnxqKnSYvcy6jJzySB96tjVbn2cISzQq0vAM/JdhOGLYC73Ds3hrUdu7AFX3ZaKswvkJsEbnLmu7on6LKdtrwo3pktWD2mvMyos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743056833; c=relaxed/simple;
	bh=4iPqEownfZun9ocmKKi7zJNNMBSkFzM3sXB70zz1tZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7JNKh2a63k1l5e36qki0B7FB0x/9JIad8MFDo3nfzyCzX5McAwcYLagwX54VE9oe0tB3RaYIlAJ90KlgR6XtIS1Tp34/LBcQXlr8kS84PTzpSW+WuCmQVlEgWDGMUQv1jkKIeBfmcLAvcm3/JLY8bSGosYnCQaA3pz5AmqBRKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URV7Mfnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692B5C4CEDD;
	Thu, 27 Mar 2025 06:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743056832;
	bh=4iPqEownfZun9ocmKKi7zJNNMBSkFzM3sXB70zz1tZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URV7MfnnZzVHzSrp0kSrrCX6GPwXwD0EWstUg5P6qBX6z1XMJaP6lPkc9AWGqlvdp
	 yOAASaFJGs3LRFmMaXCKfr+81CQ3lmMBwW2TBHoRIG0+jotmQdRzSiVCA58JiXEsuQ
	 opGVa2V6euM0QxifGfbPVU7VZK7atR01mQ3xoZvNfhZvqoBYcewTF4NIGKTE4Cnu+P
	 4Mt59FbxeKy3PAUS1eRuNx5Orgj7jzqXkrkEOoOztljzfV0r6xoWowhNKaPViMCifT
	 YzL89HG4cOJMmkUKca5ZXTOkX4MrCtZ+pPtz6Sb7C5ruYd+swgLAGmCP08FV5U3u89
	 kYBq0g8iH2VkQ==
Date: Thu, 27 Mar 2025 06:27:09 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lukasz Majczak <lma@chromium.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] watchdog: cros-ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-TvvUsB0eK2p8YJ@google.com>
References: <Z-SBITmMfwjocYwL@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-SBITmMfwjocYwL@kspp>

On Wed, Mar 26, 2025 at 04:35:13PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> rivers/watchdog/cros_ec_wdt.c:29:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
 ^
 d truncated.

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

With minor comments,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
> +			sizeof(union cros_ec_wdt_data));

s/buf/msg/g makes much sense.

> +	((union cros_ec_wdt_data *)buf->data)->req = arg->req;

Or,
*(struct ec_params_hang_detect *)buf->data = arg->req;

> -	arg->resp = buf.data.resp;
> +	arg->resp = ((union cros_ec_wdt_data *)buf->data)->resp;

Or,
arg->resp = *(struct ec_response_hang_detect *)buf->data;

