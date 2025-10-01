Return-Path: <linux-kernel+bounces-839080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416D8BB0C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF232A181E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677ED26E718;
	Wed,  1 Oct 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnoGdsTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5884264623
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329887; cv=none; b=cozfxJiKlst3mj8e4anyZteOUypb+8j+wTYOoNWoBlYJKGbOFDY2lyhAJn/CHUI7ob7gmSQcZy9l3feC5FLzBywOwClg/sGufO5u3XNL0wuQQAqVxIwOyR3RpWprSHOT3AT/MHrIlVXdR5uTxjcalGM0cuKqstUPNx/IrXLUvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329887; c=relaxed/simple;
	bh=cQwmw1vIG2Z1oQ+E//b51h+H+sXp0Zy9tBEL3nDBsSg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iMjAVl+ILDVrrhEmlUD+EuLXkzPko9Gjrh9bghn5y3TebkYRr54xnUSb2Xf7reMXVDEx9KJn/0etF9VLb6cXi/aXq98EUh067xLTfWptTGFCfbe0/PNjbAcEwSxTlzHJdQ8aTJYIzYN2XQ5s4x1nqi7ZkzrI4axGwpxQPF16UeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnoGdsTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66386C4CEF9;
	Wed,  1 Oct 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759329887;
	bh=cQwmw1vIG2Z1oQ+E//b51h+H+sXp0Zy9tBEL3nDBsSg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=BnoGdsTq1UAZcjyaTrm+nBtCe/2hAD9rn9Aa/X2bzqyhPgOLrsil2SCns0jSqjSwz
	 O7gIenMF7PuhIIJRqIz5Y6gt8o8gBW9Jz6nTef5QXtnPEJJ0URbvAwJ4bwOoOYPQWf
	 xGAhFBfR8EIODr+DXon1kfeW5SEVj0vbe4UxYJvXxyZSHEpJ/Vr4mHd7e7Unvr1gcA
	 Bp9PLjdC+hKzAj2xuhRL4EhcGJrKwVA73x2R0P+x8eX4/8Lk2nPA6ECnmsRGUEW6a4
	 ebwjaNuTnOxwAiPQlSzLCfbci0u8ZTnKbtcB5Amkz4QzpU4/BC0syow34xamD+pOJH
	 VjUHYolYongLg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3y65-0000000Eb2L-2BLy;
	Wed, 01 Oct 2025 10:46:25 -0400
Message-ID: <20251001144625.373974129@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 01 Oct 2025 10:46:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Berg <johannes@sipsolutions.net>
Subject: [for-next][PATCH 4/4] cfg80211: Remove unused tracepoints
References: <20251001144605.585204794@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Tracepoints that are defined take up around 5K each, even if they are not
used. If they are defined and not used, then they waste memory for unused
code. Soon unused tracepoints will cause warnings.

Remove the unused tracepoints of the cfg80211 subsystem. They are:

cfg80211_chandef_dfs_required
cfg80211_return_u32
cfg80211_return_uint
cfg80211_send_rx_auth

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Link: https://lore.kernel.org/20250828221759.131160ee@batman.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 net/wireless/trace.h | 56 --------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 34c584a215e5..9b6074155d59 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3137,23 +3137,6 @@ DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_notify_new_peer_candidate,
 	TP_ARGS(netdev, macaddr)
 );
 
-DECLARE_EVENT_CLASS(netdev_evt_only,
-	TP_PROTO(struct net_device *netdev),
-	TP_ARGS(netdev),
-	TP_STRUCT__entry(
-		NETDEV_ENTRY
-	),
-	TP_fast_assign(
-		NETDEV_ASSIGN;
-	),
-	TP_printk(NETDEV_PR_FMT , NETDEV_PR_ARG)
-);
-
-DEFINE_EVENT(netdev_evt_only, cfg80211_send_rx_auth,
-	TP_PROTO(struct net_device *netdev),
-	TP_ARGS(netdev)
-);
-
 TRACE_EVENT(cfg80211_send_rx_assoc,
 	TP_PROTO(struct net_device *netdev,
 		 const struct cfg80211_rx_assoc_resp_data *data),
@@ -3480,21 +3463,6 @@ TRACE_EVENT(cfg80211_reg_can_beacon,
 		  __entry->prohibited_flags, __entry->permitting_flags)
 );
 
-TRACE_EVENT(cfg80211_chandef_dfs_required,
-	TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef),
-	TP_ARGS(wiphy, chandef),
-	TP_STRUCT__entry(
-		WIPHY_ENTRY
-		CHAN_DEF_ENTRY
-	),
-	TP_fast_assign(
-		WIPHY_ASSIGN;
-		CHAN_DEF_ASSIGN(chandef);
-	),
-	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
-		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
-);
-
 TRACE_EVENT(cfg80211_ch_switch_notify,
 	TP_PROTO(struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef,
@@ -3862,30 +3830,6 @@ DEFINE_EVENT(cfg80211_bss_evt, cfg80211_return_bss,
 	TP_ARGS(pub)
 );
 
-TRACE_EVENT(cfg80211_return_uint,
-	TP_PROTO(unsigned int ret),
-	TP_ARGS(ret),
-	TP_STRUCT__entry(
-		__field(unsigned int, ret)
-	),
-	TP_fast_assign(
-		__entry->ret = ret;
-	),
-	TP_printk("ret: %d", __entry->ret)
-);
-
-TRACE_EVENT(cfg80211_return_u32,
-	TP_PROTO(u32 ret),
-	TP_ARGS(ret),
-	TP_STRUCT__entry(
-		__field(u32, ret)
-	),
-	TP_fast_assign(
-		__entry->ret = ret;
-	),
-	TP_printk("ret: %u", __entry->ret)
-);
-
 TRACE_EVENT(cfg80211_report_wowlan_wakeup,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 struct cfg80211_wowlan_wakeup *wakeup),
-- 
2.50.1



