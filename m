Return-Path: <linux-kernel+bounces-803727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C236FB46463
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9873D189991A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150D22868A9;
	Fri,  5 Sep 2025 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZBk349J2"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC128312E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102935; cv=none; b=OCsPF25QJDwy4nHRp1TXrm1zJfPqVLkU8xD9QEhBmTlSMevwEpX2igJuJpaRwF9ND6H8DURFty/UtL0LQm4JUha6MP6fetvJNkt9aQQT1oFQqctqzJZH+csbDWxD9Aw9Io0VomupehXML20lKh3yW6uJAs3PRtEgjsBCZ6VGEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102935; c=relaxed/simple;
	bh=+KB+mWM0AOSmy2YJlBASWfBtkeYT9jSG7Yq251tk0CE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=j6gpX6z7QJFMbOQFfmshgsR5Kg3/4Jp6d77UYb2v4vqyeK4HyRW+3RvHA2R0k1gxhNM77ZLoE3RG0UAJM6E8vi2N87iViLoX//ggH/9j1lbas4U1GxPIbCGI+cF77zEtZSZaKwv+cMenwRTaulIbxrQiNvRnLXH5fJ8rsU4IvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZBk349J2; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=e7qdeu3ldrcrbh7ouslcurmgqu.protonmail; t=1757102929; x=1757362129;
	bh=+KB+mWM0AOSmy2YJlBASWfBtkeYT9jSG7Yq251tk0CE=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZBk349J2yMVHQfKlTGisJYimQ7gzUwGf4R86ReK0LCxVJIZFq0Ez5djbP4ld7Fnpi
	 2aTznpk8d6NRCFquistVuazMeHp8+ppuEPj0f58oYtu5XqPQjwgsnAwWRz+NzHhajn
	 5AiryBQWhw3iWn0HVRYDBLewJOrWQkXhg82Mpa/nsOzzum2WBCLSof181oL+0eXLlq
	 /P+rlQoBt5L+0IT1etm8gW9IwkKSUVl3QLC5IA6KnjEa9Y38RxzyuRjNeb6hSozoyt
	 VBPFBieuZzHv41eVW28cs6uNZYYNfyWkTvEd0kyjpcBPBgsoffUljEmT9RHHTZxGYV
	 AtDgy6ZI00hLA==
Date: Fri, 05 Sep 2025 20:08:44 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: trustno12025 <trustno12025@proton.me>
Subject: (No Subject)
Message-ID: <xBAlUjDJWydjNphWvjMSO8qJccDIjlvTOLgabtAipjiOIhs74y4lKH92chm-1_ZnabzSf5InB1s5LLvSRtguIrA6PtV1ix16ETRFGxQ3ESs=@proton.me>
Feedback-ID: 152332093:user:proton
X-Pm-Message-ID: 9622f73e08ed89c9ce99eb1a397ce7e369e85196
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






Odesl=C3=A1no zabezpe=C4=8Den=C3=BDm e-mailem Proton Mail.

