Return-Path: <linux-kernel+bounces-823765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E7EB8765E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957B07E2104
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876619F115;
	Thu, 18 Sep 2025 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KntxePmE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8m50MwF"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020134BA40
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239186; cv=none; b=JL+Zp6bbrAVR2sd/SDwIfgPJuq5jewi6UNu0OxIZw2qDGbC5DRkh8loQkktAi5ER6eIMcG3amw5JjVP6aeyu3ErQn14Fx6hdpJSqSmXxcq6l8rWBE9XRY+HXokmSUKCSIS503DTplJndLZlVf3d5K50fJhW2hiWef2b1mbv/9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239186; c=relaxed/simple;
	bh=iFGQupn5XPpP2KjstqGmLw4s+9R+PrX8KlceWBGW5zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhiVtvnoValCGzcESLEZZ3i1khKCcl5HpcK+oiRTw4laig7H8btGni4cvACN5DyhigeG4Rb4KNWJHht2JkFYcM1KIBlWFsSEKHU/m4Cs6KoJBRb1dXpurDhPigw+4/qGvz7TUnA0cC6tr+s00MlMwRV1iXeyYTfvEbVgOv1a4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KntxePmE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8m50MwF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 97A0D1D002BA;
	Thu, 18 Sep 2025 19:46:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 19:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758239183; x=
	1758325583; bh=sWsEZtX/uvsijDe9n8yAt9hLHijgKIaNN7Dlpi/+8Z4=; b=K
	ntxePmEWuYrbO+uzZx+Ox0o9w36HsHuJlFo6DzPuODhX6zv61rUbK+ILGZcHguHV
	Snsp1coFmghQbXqWhJJik/qei4A+cqx0knxfRrnELrzSIJHaRTg0ZoIxJ2V2xdft
	EFRVpTJh+ukUbvXX/044BDfwQjF5cVglprUmAd6kWY9l3shTYrpAH8y/Pfqk1jyR
	sIsZhfwQOozehxyXkMLDJfXHthscg+EuVhy2j69AXYhI+QJiBnV+OLn5SiNHUXC0
	jJYfpDFjXM4oAK+1TR3clslGmUnnDXXNP4OB0uA/HnTCgeK9hkPeLzIUx6kHiIee
	yFEaZ+748Gict5cPIV31Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758239183; x=1758325583; bh=sWsEZtX/uvsijDe9n8yAt9hLHijgKIaNN7D
	lpi/+8Z4=; b=O8m50MwFhGBzbf9tHv76nzB2l/yI/pHnZvt8NLlDjtZB+VDwyHK
	5j3bI6nalh434GOksdKx5OGYC+MaKAu9XmUl/YMUwOl7xn2resMzFWpqegBXDZ1g
	Cr1cJc4ZrbR7XpoyHeHcQuvyBgg+AeW80JbOIsgrX6NixcY+1aVodbeUjU+KFXV+
	Z7kf0OU1PJBzE3mGbz1K8oPIXGq2AS7zPBdSMzbhN3UbujG+2+WHZhbgBB6ETS6W
	3e714+Z1zbDDvS4EqQPV1vnO9CEIHHkqfFFRn/xkENCHyfs6/s9BpNGCvrGUip+M
	kJgs0bHUY1NqgBmdcMgx4MJEroC9m5eT1Xg==
X-ME-Sender: <xms:z5nMaH64xwhQX4Vz3PAJXvKYLbayJJpDKHHhaeNIEyKOZnvh0mjdtA>
    <xme:z5nMaF0_uW4kCBYXij4EUzHDCtFEJMTIhbsP2jBrRD1L78m8L3diQxQZWcmLINi31
    JstlHOg2bNiDWfm2uE>
X-ME-Received: <xmr:z5nMaAZ0IUHx1RRipb9QOjtDisZi50OJ1vji8IsAeNJ5ao_KPf0hJfKhsAhOIoq9LlZKiJ3lBVbfW-59wsEomEbstNn-_XF0Pe1d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgke
    dvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z5nMaFB9mM4EOUpklYaEej7xNi9n4vzZeUMNuMg_0Grn1gBIFOdAQA>
    <xmx:z5nMaK8yFY8nMu7jYtC6aH5eq44AbMr3UhNpEjvTvjNvrN229f95Lg>
    <xmx:z5nMaN_WYacWs4h6gQ0IsIMvq6HH56FGlM9r7DTNqiWl-cCvrI4pcA>
    <xmx:z5nMaJdaE4xcPeYqzckiFkkqDdhJel6BxdGkk84eX6AKarYTyed3AQ>
    <xmx:z5nMaB86T56qkGAy98DNl7MjEIiL0ZyQWxdE3JiSe3W4q20Z-FoTYC8L>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:46:22 -0400 (EDT)
Date: Fri, 19 Sep 2025 08:46:20 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] firewire: core; eliminate pick_me goto label
Message-ID: <20250918234620.GA127993@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
 <20250918230857.127400-6-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918230857.127400-6-o-takashi@sakamocchi.jp>

Hi,

On Fri, Sep 19, 2025 at 08:08:56AM +0900, Takashi Sakamoto wrote:
> This commit uses condition statements instead of pick_me goto label.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-card.c | 102 ++++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
> index 6268b595d4fa..b766ce5fdea4 100644
> --- a/drivers/firewire/core-card.c
> +++ b/drivers/firewire/core-card.c
> @@ -388,6 +388,7 @@ static void bm_work(struct work_struct *work)
>  	int root_id, new_root_id, irm_id, local_id;
>  	int expected_gap_count, generation;
>  	bool do_reset = false;
> +	bool stand_for_root;
>  
>  	if (card->local_node == NULL)
>  		return;
> @@ -408,11 +409,11 @@ static void bm_work(struct work_struct *work)
>  			fw_schedule_bm_work(card, msecs_to_jiffies(125));
>  			return;
>  		case BM_CONTENTION_OUTCOME_IRM_HAS_LINK_OFF:
> -			new_root_id = local_id;
> -			goto pick_me;
> +			stand_for_root = true;
> +			break;
>  		case BM_CONTENTION_OUTCOME_IRM_COMPLIES_1394_1995_ONLY:
> -			new_root_id = local_id;
> -			goto pick_me;
> +			stand_for_root = true;
> +			break;
>  		case BM_CONTENTION_OUTCOME_AT_NEW_GENERATION:
>  			// BM work has been rescheduled.
>  			return;
> @@ -423,8 +424,8 @@ static void bm_work(struct work_struct *work)
>  			return;
>  		case BM_CONTENTION_OUTCOME_IRM_IS_NOT_CAPABLE_FOR_IRM:
>  			// Let's do a bus reset and pick the local node as root, and thus, IRM.
> -			new_root_id = local_id;
> -			goto pick_me;
> +			stand_for_root = true;
> +			break;
>  		case BM_CONTENTION_OUTCOME_IRM_HOLDS_ANOTHER_NODE_AS_BM:
>  			if (local_id == irm_id) {
>  				// Only acts as IRM.
> @@ -434,60 +435,61 @@ static void bm_work(struct work_struct *work)
>  		case BM_CONTENTION_OUTCOME_IRM_HOLDS_LOCAL_NODE_AS_BM:
>  		default:
>  			card->bm_generation = generation;
> +			stand_for_root = false;
>  			break;
>  		}
>  	}
>  
> -	/*
> -	 * We're bus manager for this generation, so next step is to
> -	 * make sure we have an active cycle master and do gap count
> -	 * optimization.
> -	 */
> -	if (card->gap_count == GAP_COUNT_MISMATCHED) {
> -		/*
> -		 * If self IDs have inconsistent gap counts, do a
> -		 * bus reset ASAP. The config rom read might never
> -		 * complete, so don't wait for it. However, still
> -		 * send a PHY configuration packet prior to the
> -		 * bus reset. The PHY configuration packet might
> -		 * fail, but 1394-2008 8.4.5.2 explicitly permits
> -		 * it in this case, so it should be safe to try.
> -		 */
> -		new_root_id = local_id;
> -		/*
> -		 * We must always send a bus reset if the gap count
> -		 * is inconsistent, so bypass the 5-reset limit.
> -		 */
> -		card->bm_retries = 0;
> -	} else {
> -		// Now investigate root node.
> -		struct fw_device *root_device = fw_node_get_device(root_node);
> -
> -		if (root_device == NULL) {
> -			// Either link_on is false, or we failed to read the
> -			// config rom.  In either case, pick another root.
> -			new_root_id = local_id;
> +	// We're bus manager for this generation, so next step is to make sure we have an active
> +	// cycle master and do gap count optimization.
> +	if (!stand_for_root) {

I realized that the "stand_for_root" local variable would be
ununitialized here at the case of "card->bm_generation == generation".
Let me post take 2.


Regards

Takashi Sakamoto

