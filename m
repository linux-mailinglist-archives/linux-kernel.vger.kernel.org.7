Return-Path: <linux-kernel+bounces-789935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BF1B39CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2AD18826DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B884D3597A;
	Thu, 28 Aug 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dpXi1dXr"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61814A4DB;
	Thu, 28 Aug 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383545; cv=none; b=JDIs8T0jkKLUEsqGcuhLv5mAiJBcNDiThkRrDwq5Oxf7vP3XNouEX28Q3vEOJ61KUQuiswDOzjptKtFvmci5k2KhBAtMfp02j6I0s1KKSfMZYQVOvxZGn53WOZBEs641OJDOdCasOjfl0hDUhfhpLLbFEALPrMhphVaWzgxQf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383545; c=relaxed/simple;
	bh=R1Zh6DVmX5hm+nHLOR3DImfFjAfSm0x/soS0zR7zvUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhq6JmySIFmrNPOya+YguoW/eeDqgU/Oegn6zgr9feTtqXD/E3+00z8NZlYk0yhtUYQndOherdUqa4tjHhp+QBJ4gHyMrWweWqgvIHpihXYXASpW52Mt2PhQA+2doMD029WUYTCNzbzoGaxYmdhICqzl4v/FK8iDUYtH97Em1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dpXi1dXr; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=R1Zh6DVmX5hm+nHLOR3DImfFjAfSm0x/soS0zR7zvUY=; t=1756383541; x=1756988341; 
	b=dpXi1dXrbbcQDkpIxu32Dz0bHkqotg/0bskdB+lBjEst2TaeZgqyP1g1habhAxP/xn09jY4Ti+5
	4KiFRcZy/QMf9mLkE9lFAgiAaxtd0l62wWRPGC2mfqquEwNlLU1VgHCb22LD8uygb2hdLkfbe6BMy
	CQXHWoyKyVRw+y+4igyYqaRqNquXprxn9MtfMyO/3GH100lc8rxQE0I/Z/euW6K0JZh5u6wjgaUEH
	hNCXk5znjsJexRF73ZPa/z5loaDnduTe/DP8J/imdZpSnBB70QqGs4jv2ZlHek5pj7gpM1BkB0Jhf
	JAe8Y7R7uXBe2ojykl4j8zrF1LTa67chR43A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1urbae-00000003vVw-3uJG; Thu, 28 Aug 2025 14:18:52 +0200
Received: from [89.57.34.174] (helo=Geist14)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1urbae-00000000HjT-2vPq; Thu, 28 Aug 2025 14:18:52 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: sparc: Another fix for accurate exception reporting in copy_{from,to}_user
Date: Thu, 28 Aug 2025 14:18:35 +0200
Message-ID: <20250828121844.2250-1-kernel@mkarcher.dialup.fu-berlin.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PTO

As a follow-up to the series sent earlier to fix accurate exception reporting on UltraSPARC,
UltraSPARC III, Niagara and Niagara 4, here is another patch to fix accurate exception
reporting on M7.


