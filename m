Return-Path: <linux-kernel+bounces-763570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF7EB216BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840A11A24794
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D92566F5;
	Mon, 11 Aug 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrusk.com header.i=@andrusk.com header.b="sGLU7Y5/"
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E9311C02
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945187; cv=none; b=bcbahJuxygk8bn8lw9AVqkPscKzqv4rgv+x3wAvqCuEzdyYHyU3zAj6GaTUjRY+XlTOs92dppBz67i0nCJbCm4/zi2rN2AII0wQeeANKZCv+kEm3kMPG/y+O3Y1OiADSpRTiDIJadt4KvuWDy/JRjWWdxQ+GT1yAzLFEAX8T1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945187; c=relaxed/simple;
	bh=mchRWOmhPpMgucyL1pz0WDOkKB8tqTbDDAgbP01aZx8=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=Fs8UP7i6AfYdk0MiXh0oKOYW5qTx6DPkKqzLcqQZOgRaE5CRCHZGXErcNBtq2lc3gzVQga+QFYe34Od2IYxLCDda76ZbV7QrdF+RTXEJsnM9ID2kj5tyRfG2gicCFg9+bE6qw+bMlNLEh13QAWMdJO57mjWqajTCO/ZiOvC1K18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andrusk.com; spf=pass smtp.mailfrom=andrusk.com; dkim=pass (2048-bit key) header.d=andrusk.com header.i=@andrusk.com header.b=sGLU7Y5/; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andrusk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrusk.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrusk.com;
	s=protonmail2; t=1754945183; x=1755204383;
	bh=mchRWOmhPpMgucyL1pz0WDOkKB8tqTbDDAgbP01aZx8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sGLU7Y5/rvvpCGZ5DoWa5Fridrf/HlLHQ5jDGku6wL83ZQqeIQTmp2gd6hEpoKVDJ
	 knWAGxpXDVuCr6ilai8T7ojEtgP2mwZEPvAK7GN+zg33Ppqp4/ba/HNkBU6TsH1ZsI
	 MM7yK9yt3RpFO84liJhvWxC90dxyQ2J6gyu7ZI3JYsYJnHn5B5h6eYkRij5BpFYR48
	 8rBwqmX/CDEqa0WlHdd27KVEPgR06zC+mMaxqOZDQ4/NOGEsbwb1Ng0xGV6IQSnfVO
	 +NQv9YKw3F/pWqXOPxhs1svG6pN7rHc6AB8fCg6lo6g3OwuWMcQ9BsaHveEnRySdtv
	 8/I3MNM9vjb6A==
Date: Mon, 11 Aug 2025 20:46:19 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Justin Andrusk <jra@andrusk.com>
Subject: subscribe
Message-ID: <87pld1bn8n.fsf@andrusk.com>
Feedback-ID: 16009080:user:proton
X-Pm-Message-ID: 80bf49ef909f114b5549bd47fb1dcc8c0f0202ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

subscribe
--=20
Regards,
Justin


