Return-Path: <linux-kernel+bounces-834273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C7BA4517
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152A974043E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361F1E51EC;
	Fri, 26 Sep 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7KgpEcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857816132F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898774; cv=none; b=RAitA502VBm2kYL+oQTYGZkLvYX4vZ4bpKszGdx1XN0tKnlfwxnhKGg5KpuEevzZI8ajC/eTKbCBDTG2XqrPQSGQ0lxDdRyHw5Y8v/1l1ABpeEfjtHbPQddKgbLY96pnX+HfXuwUx3sO73NoAES1BnROukC1jGE8S4gcISbNO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898774; c=relaxed/simple;
	bh=0wNINZj/0cp7ofXzw1jVRESj9qK7dxg/w6IvrdV6EEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=maLu6YpxjM2Q98qN2R3T0MSzq1/Uof5M7mhKmyCnGeXpCNeMLsc3fTJNOX1tGR5sqqI4Q27f/iQ5NIhgf3MZuqMMsJlG5RIItsXTmv+HD7mOmAJEVu9cswHVAERrcSxKlGbUmC0d/Wx2WsgTYS99BTQ2uWqUKohCNHW2smnyJ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7KgpEcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B8CC4CEF4;
	Fri, 26 Sep 2025 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758898774;
	bh=0wNINZj/0cp7ofXzw1jVRESj9qK7dxg/w6IvrdV6EEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b7KgpEcZu0sU9dq67N9w9smfPOxSFOqdYqogIluWNPtoWRimBVGoUYTr32fp3rpEi
	 LLRFDqOv33i+WzKp96GSxpaSdtqs8sD0WX1T/0DdrVK+YD8Cd4aYSbFPdZQr9l/1KX
	 6WuH99jAim6ZLG0wzVGiyrqPZo9LlMJ7NO5824QMw59lycr7/4L0fJL95ybvjesjUA
	 2tNN65QM66Ff96FqCMLu7Id6Q3g4ZaIhWLyPpzg1E4mjnL3jjhyPdhed/hAwxCuEPH
	 HHqO1XvmG3rYrcvHy5Xtfvi4PIuRPm40byfSeIS4wc/vS+VkhoshoFJp6D0jrUJ5ph
	 TEpl665/tWHZA==
From: Daniel Thompson <danielt@kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20250817231349.633458-2-thorsten.blum@linux.dev>
References: <20250817231349.633458-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH RESEND] kernel: debug: gdbstub: Replace deprecated
 strcpy() with strscpy()
Message-Id: <175889877309.8040.3227655030870638662.b4-ty@kernel.org>
Date: Fri, 26 Sep 2025 15:59:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 18 Aug 2025 01:13:49 +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> 

Applied, thanks!

[1/1] kernel: debug: gdbstub: Replace deprecated strcpy() with strscpy()
      commit: 05c81eddc44733fee60d4c55508c76017995900e

Best regards,
-- 
Daniel Thompson (RISCstar) <danielt@kernel.org>


