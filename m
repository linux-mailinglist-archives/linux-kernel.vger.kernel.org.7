Return-Path: <linux-kernel+bounces-849633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB024BD08D2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40DF54E68F4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5252EE5F5;
	Sun, 12 Oct 2025 17:42:36 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0C2D3A6A
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290955; cv=none; b=r9raQ29csmO+o1J8Hv0xwQzeHeHacEZtM5Vebry5ri/vsgg2WBw7xmzRAFLKHZ/ClcHVnwe14jSWdc+039PX+2aiWtr7wCGZNROlCukCFWoQcU5PJEk8USbc8oIuCUtG3EynrM9CiuA/SrGCuTINjayMwbxSfiJlouq0i77ud0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290955; c=relaxed/simple;
	bh=C7TwX3EAWvnTw60Frvz1WhYP3z15/5cYC0u80mqbghc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkSwZFSouS7GprwQE1fFokXrkb6xP4I5FOptKg0Xy46lrHhjtvr+ZExHlWzxNhVnNW6/6DRzf1e9zLaVEK6kVCpiNkDC4bXHo1P1MTwF3maNO5WCuJB7/8xxAG+2jQX/l6diuOzmx0SuIHsFeNEFBmnAZd6S0Kr9RAnXtnHJC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [82.141.251.28])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id BBAF842344;
	Sun, 12 Oct 2025 17:42:24 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 82.141.251.28) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34ddaca59.ant.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud lecomte <contact@arnaud-lcm.com>
To: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	contact@arnaud-lcm.com
Subject: Test
Date: Sun, 12 Oct 2025 18:42:21 +0100
Message-ID: <20251012174221.72873-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <688809c1.a00a0220.b12ec.00b7.GAE@google.com>
References: <688809c1.a00a0220.b12ec.00b7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <176029094526.7998.3728785312181432620@Plesk>
X-PPP-Vhost: arnaud-lcm.com


#syz test: https://github.com/ArnaudLcm/linux.git bpf-slab-fix

