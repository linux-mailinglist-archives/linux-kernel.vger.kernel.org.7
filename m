Return-Path: <linux-kernel+bounces-781260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA1B31009
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440BB5E1CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111792E764C;
	Fri, 22 Aug 2025 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="dHfgWtgJ"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C9212FB3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846874; cv=none; b=j35knSd2+wie+OGDrKUeUr5JgrvAd5LMgH2uhC06/uwWr+n5nkk48/AeZPNUb2JVBD6xg64CMEXjpcGCgkwjGbf8zcDRFselNgHIjyTsMqy3p2eyk8Q8euWpchl5ei5MFDZvdFj+1wNsjsgV9aCMl2/HhZEwsxIAiGihcwQBDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846874; c=relaxed/simple;
	bh=K3JGXfg5ueJ9Trt7ntIKgcOSsX63ZzfBfJETVGNzTvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=batckDzTXvzjDE+PevoumwKNF5CoStQt6dQrFc2jnt4hqxD6WDVfGcRbpCJjwMzLBq3wzUn3a1MlqdL16JOluEj/fG2yynu9Fjtk5QBXHInauWM352/+wFgaAD9RiPGpdXJlF/rp5qmTS0kcMe1sWE9M9duXr6xLATjyTNHUCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=dHfgWtgJ; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 44574 invoked from network); 22 Aug 2025 09:14:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755846860; bh=LqtWAHV/ZOPkZ5sTWV89Ib8PULJOZ58k/apc29IXCpY=;
          h=From:To:Cc:Subject;
          b=dHfgWtgJ9z8ShrsdQfUMjCHhjtGJ+Nx7P1/FPK3Wlip7ptGw2tO+KMw/dkO5k1gae
           tyyDY7DBM0IwfzL36Odt47iM7hjLUAtpmMEZ87vYykM1Rn2EOgcXZFClSYVKitUEo+
           99wpF/VBAr9cQu1BvDxZWijaSqgovPZdT4F4PAgDjQ5SUVo3scgsd8bJ+QfpobAFnz
           ertwy404fN3wTbrRz4Z1Onem52GBeebj2TVC0FJkmi3Bn5CytRJnGtYzkta0Rn0oLH
           DQEYW+kHC7XcKj+hYIBQ7c+W8yq8Leo1Fp/SFoios6DcyA6DGp8c2J34HJAYlE8Ihy
           RiTZ2Fl/2zVEA==
Received: from 89-64-9-131.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.131])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gustavoars@kernel.org>; 22 Aug 2025 09:14:20 +0200
Date: Fri, 22 Aug 2025 09:14:20 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iwlegacy: Remove unused structs and avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250822071420.GA46129@wp.pl>
References: <aJl7TxeWgLdEKWhg@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJl7TxeWgLdEKWhg@kspp>
X-WP-MailID: aa1691429c86c2fecbca16863494ab9c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [ETJx]                               

On Mon, Aug 11, 2025 at 02:10:39PM +0900, Gustavo A. R. Silva wrote:
> Remove unused structures and avoid the following
> -Wflex-array-member-not-at-end warnings:
> 
> drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h:68:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h:60:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  .../wireless/intel/iwlegacy/iwl-spectrum.h    | 24 -------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> index 1e8ab704dbfb..f00eb878b94b 100644
> --- a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> +++ b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> @@ -50,28 +50,4 @@ struct ieee80211_measurement_params {
>  	__le16 duration;
>  } __packed;
>  
> -struct ieee80211_info_element {
> -	u8 id;
> -	u8 len;
> -	u8 data[];
> -} __packed;
> -
> -struct ieee80211_measurement_request {
> -	struct ieee80211_info_element ie;
> -	u8 token;
> -	u8 mode;
> -	u8 type;
> -	struct ieee80211_measurement_params params[];
> -} __packed;
> -
> -struct ieee80211_measurement_report {
> -	struct ieee80211_info_element ie;
> -	u8 token;
> -	u8 mode;
> -	u8 type;
> -	union {
> -		struct ieee80211_basic_report basic[0];
> -	} u;
> -} __packed;
> -
>  #endif
> -- 
> 2.43.0
> 

