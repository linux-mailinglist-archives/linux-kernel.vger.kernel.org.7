Return-Path: <linux-kernel+bounces-853413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA2BDB943
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F70192831F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED14030CD8E;
	Tue, 14 Oct 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RFfXKzkL"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882E30595D;
	Tue, 14 Oct 2025 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479837; cv=none; b=G9QwJ5VJmzmmxgJ4WRn6HzRzMpSDbyKX0mBxtAh0D3VfXW+1o2Qe1xinWyTJFqn1JuI6RqBlSRjBzyVP4Y6D36Qia8+VoqjJk6W1MiFIc1JlR+LzsIP3G8Gp+46BqZN1VUTQiOGXqDTuQseo7ywJnapeQlgfcqCFk4teeAdlQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479837; c=relaxed/simple;
	bh=3ib1iU3Qxw19Ut1WEzRnfFFufKNvW6qoaUWizLUq11Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKA2+f9zSoQVVhLjPQ5Mn/znWi8di5g47HxvL8i5DTEeo14j6kiy20ZO28bHosHL2fHiajTbuEVRA6Q5fEx9OD1AFxDo0PP42u7DoElF6q1Q2CTDGl80XBcxo4UZ3XTJcOmfMejC5aLgEGVfU/sZWVRyJ9oHGlN0T7BgRhURvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RFfXKzkL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760479451;
	bh=3ib1iU3Qxw19Ut1WEzRnfFFufKNvW6qoaUWizLUq11Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RFfXKzkLQtwUueDyCrkSuazpG44SGbxqEHdEVqA6yRD7EsZxBZcdlMsE+zAhISIeA
	 2pxWVSQWI3POKOY1yaS+c0Zmq0hVWF0BVwVLUcSKkuOjxEo4du64sz0+3f8eqc8ppV
	 9AFbkGKLp8TAGcRnlg29Nb57Ax2cf4tly1tUNCp6wHzoTby0gn4Zc5FM/9vfsm7t1l
	 za6awf81wSsV/ZXamUjdMf98iKiPeYBa1IdjJn5R+9qgvbk0a4e15gdnLjv+wr8NEP
	 BrwCGW/HlU/YsqccXVvyIqWJGK/d6eOLB3gkZ+g9cXYT/o+uTQNdCQAnSpo6UrGbI1
	 0uj+NvXVHyfuA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 974387699E;
	Wed, 15 Oct 2025 06:04:09 +0800 (AWST)
Message-ID: <b387257937922d62fbf6bf6377470cfa8a46da2f.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: ipmi: Convert aspeed,ast2400-ibt-bmc to DT
 schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Corey Minyard
 <corey@minyard.net>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 15 Oct 2025 08:34:05 +1030
In-Reply-To: <20251014152948.3782738-1-robh@kernel.org>
References: <20251014152948.3782738-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 10:29 -0500, Rob Herring (Arm) wrote:
> Convert the aspeed,ast2400-ibt-bmc binding to DT schema format. It's a
> straight-forward conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks Rob.

