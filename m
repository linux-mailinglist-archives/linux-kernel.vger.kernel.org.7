Return-Path: <linux-kernel+bounces-829802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA9CB97EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80CA1699FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8951D6194;
	Wed, 24 Sep 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="d779PpkY"
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D01A0BD6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674645; cv=pass; b=NR+dYRVqK6ElYoIukKy29C/vIMgbWVzvX7A06kmmKpU1pR3DmlywNL4xT2zwU+f4vFhAZQC6vdC1C4opSaFaHjL0pjpMvIakIa1X59FfMrNNcEse2ClauUp6ieiuWcdweOwfyeVv1QMXW4osK2YOMrimf6geQJFlHQTjk45ZSVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674645; c=relaxed/simple;
	bh=RaWxYIecNu51BIXi3aTlU5HF5n0Dc8Qto6AspBr+35k=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=er7xl0a+GWS+RmNGHA5sA20TFNpGxTWgY8uCUxoaZ3EGCzNMojDy6Y1io23vhS/s9uZtK4OQpgP3DeiB7YY4t/84IIGidXrPmPn/dULSVO4uygpwwU265zOQ/7V1Gv7iV1go4mui8/U6JdyhW7Mpfc5olw2hTdUKv+PhDPAPkss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=d779PpkY; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674643; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=oIGxdjekKMn08LdYbhpJfheo/ugSXP8KsvrjKReadBAF8WaqMe3hfv4xNAcm3SWDGiEQxyMLtTA9SpJ6XvcAvlN34O7rpdSnqdToC1M8X4K05b2XcB+LUj7vpZu326vbpYSRk3UomEd7zJ3WJWicyWO03a5/VTv1qsYzjINDalU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674643; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=RaWxYIecNu51BIXi3aTlU5HF5n0Dc8Qto6AspBr+35k=; 
	b=ilURJcNkJ18LQF8HcgsEbv1Nj54FaxUrdNc4Wn4z9EDsGAY/yo4Crj8WW/suOjvaqCZttEISfc/GvPtVvcdcJUZatWHQFHmkXqVFVFFHCk8vW3VmeNpenb7kbOWvouGg7INh39rR0ZNa1d7+twaRKKsV8YjMXbs9KG0vngqQwoM=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a7a7580-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653154705.745999295184;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=d779PpkYWyliZcKWqN648SNHP+tQr7yNbsfFBwbq/fOvnB6P8q+fzv/m+xhZsQHYt7EDZiSDqQ+FR8jHh9leYZMx06cWtOTpURkBJEX1ZKFoWlheTuoZ6LsbqFoQ5VWZULYBhu2jyCmNwBIbMb8vfWAap7+zf7Bui0ZAygbbelY=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=RaWxYIecNu51BIXi3aTlU5HF5n0Dc8Qto6AspBr+35k=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-kernel@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a7a7580-98d8-11f0-9ce0-52540088df93.19978ffc4d8@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a7a7580-98d8-11f0-9ce0-52540088df93.19978ffc4d8
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a7a7580-98d8-11f0-9ce0-52540088df93.19978ffc4d8
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a7a7580-98d8-11f0-9ce0-52540088df93.19978ffc4d8
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a7a7580-98d8-11f0-9ce0-52540088df93.19978ffc4d8
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a7a7580-98d8-11f0-9ce0-52540088df93.19978ffc4d8@zeptomail.com>
X-ZohoMailClient: External

To: linux-kernel@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

