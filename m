Return-Path: <linux-kernel+bounces-791725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB6B3BADB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E6189CB12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDC6314A60;
	Fri, 29 Aug 2025 12:10:14 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12E229B1F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469414; cv=none; b=u8Sv3b/MDmk6vJ2iBBW8rULWekE/gwPyY65Q6VHgfQtuHAhfaNud9hGyCKhCNqq0GAAFj3ynr0R2swbV6mhwqLWTiyjlZIJZ5gfREicfZuW54gEM2keuCTogfmcfyaMA9PiOC79YY6sah6VxP0f7e3wUNOQd9X8pQ4X3R85ySlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469414; c=relaxed/simple;
	bh=+9MVFc7DASe1FmR0cm3m6TMF8xTuVhtzNT54l8kTPjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmu2axdy3EtUuaRiU3W6bkI5kqBSrArmtOCy/sQwaXTuJC8QftKeW/H9Ci4KLnNm/3WYKakRKdmFZ8sCANPXs6TRHHQA9KJ+EFM5F9j5G7AdnPFiHL2VTVkoI1gG4TqTr3/q4qKVHFs6HZ8bFLoWaswy1ZKmN7STK7A43+EGQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 98F1B1A0715;
	Fri, 29 Aug 2025 12:10:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 9EF6320024;
	Fri, 29 Aug 2025 12:10:02 +0000 (UTC)
Date: Fri, 29 Aug 2025 08:10:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [for-next][PATCH 0/3] tracing: Trigger a warning on build if a
 tracepoint is defined but unused
Message-ID: <20250829081024.4a42e5be@gandalf.local.home>
In-Reply-To: <20250829070224.503ddc8a@canb.auug.org.au>
References: <20250828182754.733989525@kernel.org>
	<20250829070224.503ddc8a@canb.auug.org.au>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: y1u4q9zo7ze1uws1absd9yctcmmwnn1n
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 9EF6320024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX196yDeeqTDDoMS2+OzzTqLDbzVdGeFDfV8=
X-HE-Tag: 1756469402-276621
X-HE-Meta: U2FsdGVkX18Lqv0KFlMIqQDfCwJI6lFNSS/87nfL18+NJOAgsT3hxcDo9UIVXkK8954dSQWiJQOOq1Tjsdeq4yysHjenAlhui9vn3uqugSNuvgxLNLBpg9dZYjJRpwPizuCJew8IkA+RPDmVp+Rrt0FDrOKtrEGE9ftjkqypAw4/SaefYKQ4HMlmnF/Wjt41ugIwIRIj3uMvXJlcCZFF+IdeaQwE1QBS8IxntzfRldT2rpBaZRt2XzmDG7tGr7VOKJCeMsz8gkA3xZdsfG0EJblQlpCW8kH+JYGeKS8gm61+1IGbVi/tfXiaWY1wjsjvkgYNEAfYWJyoAKwMqhyDCo+Sa/JyxmQabf63sKtjZoMiJob+PGOI4boT9xnxz5XQ

On Fri, 29 Aug 2025 07:02:24 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> But, really, these known warnings can just make it so much harder to
> notice new ones.

They all should be fixed. Note, this is not a compiler warning. It's a tool
that states "Your code is causing wasted memory to be allocate in the
running machine". If your tracepoint shows up in this list, then you should
fix it.

On an allyesconfig for x86_64:

warning: tracepoint 'kvm_iocsr' is unused.
warning: tracepoint 'nfs4_rename' is unused.
warning: tracepoint 'nfs4_renew' is unused.
warning: tracepoint 'xfs_metadir_link' is unused.
warning: tracepoint 'xfs_metadir_start_link' is unused.
warning: tracepoint 'xrep_rtbitmap_load_word' is unused.
warning: tracepoint 'xrep_rtbitmap_load_words' is unused.
warning: tracepoint 'xrep_rtbitmap_load' is unused.
warning: tracepoint 'xrep_nlinks_set_record' is unused.
warning: tracepoint 'xrep_cow_free_staging' is unused.
warning: tracepoint 'ocfs2_encode_fh_begin' is unused.
warning: tracepoint 'ocfs2_duplicate_clusters_by_jbd' is unused.
warning: tracepoint 'trans_restart_relock_key_cache_fill' is unused.
warning: tracepoint 'zonefs_file_dio_append' is unused.
warning: tracepoint 'edma_readb' is unused.
warning: tracepoint 'edma_readw' is unused.
warning: tracepoint 'host1x_syncpt_wait_check' is unused.
warning: tracepoint 'host1x_channel_submit_complete' is unused.
warning: tracepoint 'host1x_channel_release' is unused.
warning: tracepoint 'host1x_channel_open' is unused.
warning: tracepoint 'amdgpu_reset_reg_dumps' is unused.
warning: tracepoint 'amdgpu_dm_atomic_state_template' is unused.
warning: tracepoint 'xe_exec_queue_supress_resume' is unused.
warning: tracepoint 'xe_vm_restart' is unused.
warning: tracepoint 'xe_vma_userptr_rebind_exec' is unused.
warning: tracepoint 'xe_vma_userptr_rebind_worker' is unused.
warning: tracepoint 'xe_vma_flush' is unused.
warning: tracepoint 'dpu_rm_reserve_intf' is unused.
warning: tracepoint 'dpu_enc_atomic_check_flags' is unused.
warning: tracepoint 'dpu_crtc_runtime_resume' is unused.
warning: tracepoint 'dpu_enc_atomic_check' is unused.
warning: tracepoint 'dpu_trace_counter' is unused.
warning: tracepoint 'scsi_zone_wp_update' is unused.
warning: tracepoint 'scsi_prepare_zone_append' is unused.
warning: tracepoint 'ath12k_htt_rxdesc' is unused.
warning: tracepoint 'ath12k_htt_ppdu_stats' is unused.
warning: tracepoint 'ath12k_htt_pktlog' is unused.
warning: tracepoint 'brcms_dpc' is unused.
warning: tracepoint 'brcms_timer' is unused.
warning: tracepoint 'mt_tx_status' is unused.
warning: tracepoint 'ee_read' is unused.
warning: tracepoint 'cdns3_mapped_request' is unused.
warning: tracepoint 'cdns3_map_request' is unused.
warning: tracepoint 'cdns3_stream_transfer_split_next_part' is unused.
warning: tracepoint 'cdns3_stream_transfer_split' is unused.
warning: tracepoint 'cdnsp_handle_cmd_flush_ep' is unused.
warning: tracepoint 'cdnsp_setup_device' is unused.
warning: tracepoint 'cdnsp_free_priv_device' is unused.
warning: tracepoint 'cdnsp_defered_event' is unused.
warning: tracepoint 'cdnsp_ep0_halted' is unused.
warning: tracepoint 'cdns2_iso_out_ep_disable' is unused.
warning: tracepoint 'cdns2_mapped_request' is unused.
warning: tracepoint 'cdns2_map_request' is unused.
warning: tracepoint 'cdns2_ep0_enqueue' is unused.
warning: tracepoint 'cdns2_ep_queue' is unused.
warning: tracepoint 'cdns2_ep0_set_config' is unused.
warning: tracepoint 'cdns2_may_wakeup' is unused.
warning: tracepoint 'cdns2_lpm' is unused.
warning: tracepoint 'ucsi_reset_ppm' is unused.
warning: tracepoint 'ucsi_run_command' is unused.
warning: tracepoint 'icm_send_mra' is unused.
warning: tracepoint 'open_err_template' is unused.
warning: tracepoint 'irdma_send_cm_event_no_node' is unused.
warning: tracepoint 'hfi1_txq_xmit_stopped' is unused.
warning: tracepoint 'hfi1_mmu_invalidate' is unused.
warning: tracepoint 'rvt_mr_fmr_seg' is unused.
warning: tracepoint 'camera_debug' is unused.
warning: tracepoint 'camera_meminfo' is unused.
warning: tracepoint 'rpc_socket_reset_connection' is unused.
warning: tracepoint 'rxrpc_drop_ack' is unused.
warning: tracepoint 'cfg80211_return_u32' is unused.
warning: tracepoint 'cfg80211_return_uint' is unused.
warning: tracepoint 'cfg80211_chandef_dfs_required' is unused.
warning: tracepoint 'cfg80211_send_rx_auth' is unused.
warning: tracepoint 'rdev_return_void_tx_rx' is unused.
warning: tracepoint 'drv_offchannel_tx_cancel_wait' is unused.
warning: tracepoint 'tipc_node_dump' is unused.
warning: tracepoint '802154_new_scan_event' is unused.
warning: tracepoint '802154_drv_set_pan_coord' is unused.

Each one of those causes around 5K of wasted memory on your machine.

Most of them is because of some crazy config combinations the maintainer
has, as they are used, but for some reason an allyesconfig isn't the right
config option to enable them.

I'll push this branch up, and if it causes issues for you, I'll remove it.
But then, I'm not doing anymore work on fixing this.

-- Steve


