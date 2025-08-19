Return-Path: <linux-kernel+bounces-775557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768AB2C093
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8AD16A394
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE1732C302;
	Tue, 19 Aug 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hBxzjsnW"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9032BF46
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603066; cv=none; b=dxjePmFb/xlRuNBzBIb3lRZuMd3YRB+qaj5kBELvsxxDcSFBzHgvqzxoBy9sgIfIdch8XtYWePWEGNH+gqG2MbfUJQ8jMUrw3nTK3NIp1FCjKY37rriSn9Co4SQ06j3LBlyGG80GMD/+r0JPhRaF0cO1K9EZ7kg3zjMuXDvuF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603066; c=relaxed/simple;
	bh=bL79TkXLSKyvZYTAzeB0+GrBDYjaKkolrHs8/aZBgUA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n57/Zm4v5m1Gk5ffJp6fvUzXZ1B8VpOXSENkb0hDpFNd620wdOLtqExlQZv5gJKndTJboa1Ue3p/IdHXQifmycfQ+PgWZts8e09jN8hHiLub5Kd6p5iUS1XtJpuDQjZ8nhpbxBe6LqWXbDTI5zJ6OFFIXjvUn1GxwpvbAaoeuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=hBxzjsnW; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1755603052; x=1755862252;
	bh=bL79TkXLSKyvZYTAzeB0+GrBDYjaKkolrHs8/aZBgUA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hBxzjsnWUS3NpHC8VouR5X3pqGh+BlxLlMONtDsdUbiZzCrL2vy1caN2C3jH2TxQi
	 l+mB9q/6EucPTDDpggnyouqe7I7Cwd8qMWA/tncwaXhc5U28TPNnGWHKgt9+GxsOAU
	 +DPIrFQrIxc0m1RaOBTQcQszUlh6871fetmxVG67ojNuncBVi8GJfue7Nmy/HlkLJD
	 vUPhSrrrpe4yNFJ87w/H7biy0cdHNK29g7I3iPglTG9y6mCFSytTxeabCWgLQQYJo+
	 YrFMBoKiZ8qc58a6J/iU/crhMd2L72SuIebHWc5aa2drtE9bsX4i9BuKSwSuII6DcZ
	 vFjK3ufeRLtYA==
Date: Tue, 19 Aug 2025 11:30:45 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: [OFF-TOPIC] Are there any job opportunities in the Linux Kernel Mailing List (LKML)?
Message-ID: <en2bwDPqFHMh8TrSLw_vEgsrP6O8e3grLVUflfFszWqVsEeeE-qlBD1MfIjd89pRZBDaSNYUAmCydYfqkUKC2v2bvSvnT8vf5U2Glr1GVR8=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 3ddf5fc5705b466dd027c6d09ea5f0f9ce1df51d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: [OFF-TOPIC] Are there any job opportunities in the Linux Kernel Ma=
iling List (LKML)?

Good day from Singapore,

My name is Mr. Turritopsis Dohrnii Teo En Ming. I am a 47 year old Singapor=
e Citizen. Below is a list of my academic achievements:

Year 1994: GCE "O" Levels Top Student at Ahmad Ibrahim Secondary School in =
Yishun, Singapore

Year 1998: Diploma in Mechatronics Engineering with Merit from Singapore Po=
lytechnic

Year 2006: Bachelor's degree in Mechanical Engineering (Honours) from Natio=
nal University of Singapore (NUS)

Year 2017: Diploma (Conversion) in Computer Networking from Singapore Polyt=
echnic (curriculum is based on CCNA Routing and Switching)

Most of the companies in Singapore do not dare to hire me. Nobody in Singap=
ore dares to give me a job.

This is because I had accidentally offended the late Minister Mentor Lee Ku=
an Yew 18 years ago in 2007. Lee Kuan Yew was the most powerful man in Sing=
apore.

I have been persecuted and blacklisted by the Singapore Government for the =
past 18 years since 2007.

I frequently get fired/terminated from jobs in Singapore for the past 18 ye=
ars since 2007.

The Singapore Government does not allow me to have a permanent and stable j=
ob and does not allow me to earn a stable source of income/money.

Since most of the tech companies here in LKML are in North America and Euro=
pe, my opinion is that they would not be afraid to hire someone who is pers=
ecuted by the Singapore Government.

As such, I hope the tech companies here in LKML would be able to give me a =
job as an IT support engineer.

I am willing to travel out of Singapore to work in North America or Europe =
as an IT support engineer. I am willing to relocate from Singapore.

I am looking forward to your replies. My email is teo.en.ming.careers@gmail=
.com

This is a request for help and assistance (SOS).

Thank you very much.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical Problems
19 August 2025 Tuesday 7.27 PM







