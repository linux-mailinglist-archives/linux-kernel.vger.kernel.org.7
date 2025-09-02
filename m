Return-Path: <linux-kernel+bounces-797023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD4B40AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF176189A320
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97FD2E92BB;
	Tue,  2 Sep 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=editrage.com header.i=@editrage.com header.b="dLtmKg4p"
Received: from beige.yew.relay.mailchannels.net (beige.yew.relay.mailchannels.net [23.83.220.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1A1E3DC8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.220.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831253; cv=pass; b=SwPmzz39zmxcvH9a3ll6bqAXrqgZqEpZTU2+Po3GL+/njd7+SJyGYMCu2qoLPeRDW8N6FGLv+wEZoVu7vcuKlE6NmN2aSouNkyfqNgV1fL4Rx8DVlcOZOrtXGGwE7gfdCNvH6HodEojqJxhjyC3SF8L7ohJKDpOrpQA7HEtI2Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831253; c=relaxed/simple;
	bh=wTp0x4tLPqeu2Q9DV08gO/SBU13R2LlZZkkWmiDgUmA=;
	h=Message-ID:From:To:Subject:MIME-Version:Content-Type:Date; b=BP8uIs54uVsUQ8BfIcs/kZPm+I+QSWKwNa4zkAuQgNWmZ0HGKebWVETXtKksC88bNhl2dKEEspacr6GJMrlONWLnxKyJWFLTTu5NADhR81U3P3m60dkXRofyiZ8ehuWWDMivo4VWnjZBl0hSO5BRPJYGbr2ZV9qaRYvYa9pozMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=editrage.com; spf=pass smtp.mailfrom=editrage.com; dkim=pass (2048-bit key) header.d=editrage.com header.i=@editrage.com header.b=dLtmKg4p; arc=pass smtp.client-ip=23.83.220.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=editrage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=editrage.com
X-Sender-Id: hostingeremailsmtpin|x-authuser|drsupport@editrage.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 391B616557F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:21:55 +0000 (UTC)
Received: from fr-int-smtpout29.hostinger.io (trex-blue-2.trex.outbound.svc.cluster.local [100.103.74.195])
	(Authenticated sender: hostingeremailsmtpin)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8948E165744
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:21:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756830114; a=rsa-sha256;
	cv=none;
	b=NkB04QLBI70VEeL1RAdlKTuQbGqkjw0RqLgcl8X5nixFm/82IDRZBAz2k4sjgQrKf/U6e8
	JJpDzIh6YEqhH31vncfxoBX8V6O9g0kd1xHluUXF9yZnJeUCbWROv3IUUdBtx2B0lRzELy
	2vqWk5wykNrzUVVS49BM+Zz4ynLCrvYl9wpgXJGYxOzn4KS7tgTXsyNgOwGBNaqkZZk6cI
	EcP41YipucRCac4ojrPvTpnb+9L8ynfWbqFCd4i/6Tt06hZQgV7a0c7LnY8ImowjS7JXhO
	61vrX8nxeGYp80lb50hTNe+fxrro8Uyn2AT5Vploch58Uv9W+m9LSO4yevTyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756830114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=wTp0x4tLPqeu2Q9DV08gO/SBU13R2LlZZkkWmiDgUmA=;
	b=9efiC4NfEtouqEyt8ZZ4jtvffh+f4eYWTe9GZWKGoK2cpSqFH2qU/Rqn3e6VCCWvUA7QYa
	E0Qdr2cB0ZbhU0jIbnGs2mQuWDFfCQmCwOatRlxDKqW9ucuVg4gH0OyFHxFxTjaBI09RF6
	r/jnDvHpVuctxgDBYaZBkYC6A4YdSWp0i1tWRTXs67ymzTwUWiR4rpm78bOzqf0JSZNs5M
	Mfyxh8ZlizDdbpLFQ59QscgHuC5SYLdo7Y5lC6xPqwgSDtcBjj1Jc+QMdoSFuBZ7VlWBPU
	ynbsX/fSqOwUigT9a/PHDbOle0Xf7kd1I1b/6xP2gZEkg8xJw94xH8Q3EKYqug==
ARC-Authentication-Results: i=1;
	rspamd-77486b5f64-ksdpg;
	auth=pass smtp.auth=hostingeremailsmtpin smtp.mailfrom=drsupport@editrage.com
X-Sender-Id: hostingeremailsmtpin|x-authuser|drsupport@editrage.com
X-MC-Relay: Good
X-MailChannels-SenderId:
 hostingeremailsmtpin|x-authuser|drsupport@editrage.com
X-MailChannels-Auth-Id: hostingeremailsmtpin
X-Troubled-Trouble: 0b177d090ea6f3d2_1756830115087_2899299348
X-MC-Loop-Signature: 1756830115087:2180666393
X-MC-Ingress-Time: 1756830115087
Received: from fr-int-smtpout29.hostinger.io ([UNAVAILABLE]. [148.222.54.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.74.195 (trex/7.1.3);
	Tue, 02 Sep 2025 16:21:55 +0000
Received: from e96a1102-e82b-454f-babe-481ad9575a1d.local (ec2-3-87-146-14.compute-1.amazonaws.com [3.87.146.14])
	(Authenticated sender: drsupport@editrage.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cGWGS4ck7z2yD3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=editrage.com;
	s=hostingermail-a; t=1756830112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wTp0x4tLPqeu2Q9DV08gO/SBU13R2LlZZkkWmiDgUmA=;
	b=dLtmKg4pVTq5zjb+YXeSxDZmECeg7EImSzeZ1I1+pc9W/WiLGHJ+Y4Do+pfR2vld8VCCDk
	ClPNazOX3Q82Mt3g8GSOXil1BX/+UKygq726oLa+hBzhVK/b0POBiyT5Gey1ci5kZLdjwg
	LdhXXwEllpKPD++bmnNzoehBFTdec+xXNQgsO3BUliS13DpksF5/9pmK5gQF3s14LW4tVV
	V6uSj31SVuPE1szs39IRwrgS03sTYhUlCAn4dlSxm0juo+W0dS4LAiuqLDs/9EW0Vv1eTM
	FdkKT5+CwtU1Dyat4CzMk1f15E0Ry8TcriiU62Cgk4lHo9YHRRr1y3BNbuPDLA==
Message-ID: <e96a1102-e82b-454f-babe-481ad9575a1d@editrage.com>
From: Mohanish Ved <drsupport@editrage.com>
To: linux-kernel@vger.kernel.org
Subject: After Hours? Dr. Sam Lavi Cosmetic And Implant Dentistry
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Tue,  2 Sep 2025 16:21:52 +0000 (UTC)
X-CM-Envelope: MS4xfE0uAB/xcl5J3CN3Gr3hFc5dK3j/hpS13tLZOyCD/ZUFEroDwKCoI0YtR1ons8lA0KCNXYkLQI10DWNNYNE7/FP/+gAMicwhgqoDt0CEU69z+HQ+GNhV hxjAPDA4rp5hB73I1Z2LO+HaZm6jh/Uc1o6z/UUvWR9ia2W5IgM9yQXDAfBAcPxllnFkEF4UmU3HrEVFU8jf5wurEHGyCmpxN7Xw34Xi27alE47mRFg3PNc6
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=68b719a0 a=VlwNVqXaHQNT1vEXKdEA7g==:117 a=VlwNVqXaHQNT1vEXKdEA7g==:17 a=IkcTkHD0fZMA:10 a=CGy6BIFyVvJXCxJuAb0A:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
X-AuthUser: drsupport@editrage.com

Hi Dr. Sam Lavi Cosmetic And Implant Dentistry=C2=A0,

Quick question: what happens when a patient calls after hours about =
implants?
Studies show 35=E2=80=9340% of dental calls go unanswered.

Every unanswered call =3D one implant patient choosing another practice.
We built an AI voice agent that answers every call, educates patients, and =
books consultations
24/7.

Want me to send you a 30-sec demo recording so =
you can hear it in action?
Just reply 'Yes' and I=E2=80=99ll send it right =
away.

=E2=80=94
Best regards, =C2=A0
Mohanish Ved =C2=A0
AI Growth Specialist =C2=A0
EditRage Solutions

=C2=A0

