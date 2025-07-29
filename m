Return-Path: <linux-kernel+bounces-749646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D81FB150F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B4818A54A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA9299AAC;
	Tue, 29 Jul 2025 16:08:40 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F73299AA1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805319; cv=none; b=jUycnkE01mmoE4b9JM1yVDnBruZRsA9CPQCTc/B25PUK+st+RLBfnLnBmjukwAOsJqRkLMNqlle2xIYi5W96BZBOcYK/qBMw5iSBleAdjjuOIgKO1xM12kBuNqvtDaNMIvKweV7pkZTBcdM8AscArY6x53FPbwkyZAyHAOjl3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805319; c=relaxed/simple;
	bh=ArhcJ9YL8b/IBzSxR4NDLdU3qInw5pmiNqNwEGHN8Co=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=esQBeYRaByHLWFWAHvAEl/x8w4mMygfKNawnjPKtICgJT73pRGbADETF8GKQgbpf2UXcILEXnDYNf81xvBwnaXLQqeS7SvmsZg9U34TRB5zCJeKGhCwouzUp2z1V1OdLbdJx4yWNwwmVXPuz2R9amHTuTm+8ARXAelvUK/ZfpVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A78C78019E;
	Tue, 29 Jul 2025 16:08:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 0AE7F20013;
	Tue, 29 Jul 2025 16:08:34 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Jul 2025 09:08:34 -0700
From: Joe Perches <joe@perches.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace
 tools
In-Reply-To: <CAO9wTFg5g5GjY=g2T6m7-jbAg_0U+OttpspxNQZ8ONK=gGJHCg@mail.gmail.com>
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
 <61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com>
 <CAO9wTFhCb7gDEo+q2SAZcn2KdUyVe-fG1E4bR_+US9k2J9DOnw@mail.gmail.com>
 <2a2bb7879e22208205fbb8f9bc56fb3c882bc307.camel@perches.com>
 <CAO9wTFg5g5GjY=g2T6m7-jbAg_0U+OttpspxNQZ8ONK=gGJHCg@mail.gmail.com>
Message-ID: <f0e8d00479f8ee855f0d0b2cd3f0028c@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0AE7F20013
X-Stat-Signature: qddwp473pixndophuwpw7f6m9una4ron
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/5D4j0B3ssDHn25tWvrvNeFrBGEBEzSvw=
X-HE-Tag: 1753805314-299605
X-HE-Meta: U2FsdGVkX189CXVK/PzwISaCh0lI6XHM1fvkXtqBxBVseulsc9AXzLw/NcWrfiUfUj1ijoK5ysyE69eX+4pfAWMaP5QPCX2FmLAnxqPnFCOJqlHjtw0DJWLofG3Wbn+4pf8ftGCQYa05AqRxSozzPfk92awqGc2Zdu+4vKpn4hTAjd7rHSi/uXhKQB0ev+PbC0J1U8mQTUu8LGURb7FRibZ8TrGcNfLJaF2zzRtnzpkqXQVjTep/iU9JRkM0NGtq3WW5uCwGkzsDWPGnfslyCw==

On 2025-07-29 07:59, Suchit Karunakaran wrote:

> On a related note, should we also suppress warnings for the
> Documentation folder?

No

