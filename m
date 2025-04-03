Return-Path: <linux-kernel+bounces-587125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9474AA7A822
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 18:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3683B7F79
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AAE2512E2;
	Thu,  3 Apr 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy68cCCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19551993B1;
	Thu,  3 Apr 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698721; cv=none; b=DwfDa0AylqcT9KMgViJJHmuO1x/IXHJcTtjZjp6mG8XFWjJKzTVanHJuksH+78XbxqT/Ee4FL33tbrk44xHu9wQqaAFCQWWNwxDm8kXVXxhdbK0ERkZ6kTEmHgss+y9yqLtqhkB9rHgJ0pLCCRL1DNNRE51b8I/ZMChgHhpUQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698721; c=relaxed/simple;
	bh=rAccSmKogNdZqOMCmUuI1Eux/x/3CMaAChmohtmbCd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V0QENzb3BzuapbpN1R789wVFL08dQ0HYvwcEs/wXWVgj20zwVv0Ysk1ScF/dbKUzZiDqxbNxJICqepmXLSSIDo8eI8JvJsmSZpSH99/yIYQbaiw6HTeBC3ebTjbpRiRWoN/zdsBjHRZfhv6LMXR6aQQZT5XNFG5/uy+TEfU7kmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy68cCCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54625C4CEE3;
	Thu,  3 Apr 2025 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743698721;
	bh=rAccSmKogNdZqOMCmUuI1Eux/x/3CMaAChmohtmbCd8=;
	h=Date:From:To:Cc:Subject:From;
	b=uy68cCCLzya5knEykk9QlaK/yc9DY2hkxl4f1N8xmkhCR6vNXbk59I2DbINpoz1hj
	 z5fgcEWGV8X4zUH5TTnXdsWWHZIM3oVNl/XDnj6FUYUJOSTJc9bQ9FNpcM7BEfW3zL
	 nctDcJnTqMKSIeHE7CEbFT8roJ+MHw/oAed09GVRhde48Xl3dVXE60pnJN/pTiS5cT
	 rOj1wjPijICVs8ilEAZIZKtuiq+u0azA2GDDfWp9yflHnjFl4QUucTR+0dONGgsXPs
	 Im/HnijfAz4lwO+20FakDpe+QTzE78JzEVLmBVX+wFTvWR+d+fFU/PEQi3sBDOsbmX
	 b/iU1xCAb6kyQ==
Date: Thu, 3 Apr 2025 10:45:18 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau: chan: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z-67Hm9uHEJs0RGw@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for a few on-stack definitions
of a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warnings:

drivers/gpu/drm/nouveau/nouveau_chan.c:274:37: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nouveau_chan.c:371:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/gpu/drm/nouveau/nouveau_chan.c:524:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_chan.c | 115 ++++++++++++-------------
 1 file changed, 56 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index cd659b9fd1d9..a7e70517b7cd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -270,10 +270,7 @@ nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
 		{    NV03_CHANNEL_DMA     , 0 },
 		{}
 	};
-	struct {
-		struct nvif_chan_v0 chan;
-		char name[TASK_COMM_LEN+16];
-	} args;
+	DEFINE_RAW_FLEX(struct nvif_chan_v0, args, name, TASK_COMM_LEN + 16);
 	struct nvif_device *device = &cli->device;
 	struct nouveau_channel *chan;
 	const u64 plength = 0x10000;
@@ -298,28 +295,28 @@ nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
 		return ret;
 
 	/* create channel object */
-	args.chan.version = 0;
-	args.chan.namelen = sizeof(args.name);
-	args.chan.runlist = __ffs64(runm);
-	args.chan.runq = 0;
-	args.chan.priv = priv;
-	args.chan.devm = BIT(0);
+	args->version = 0;
+	args->namelen = __struct_size(args) - sizeof(*args);
+	args->runlist = __ffs64(runm);
+	args->runq = 0;
+	args->priv = priv;
+	args->devm = BIT(0);
 	if (hosts[cid].oclass < NV50_CHANNEL_GPFIFO) {
-		args.chan.vmm = 0;
-		args.chan.ctxdma = nvif_handle(&chan->push.ctxdma);
-		args.chan.offset = chan->push.addr;
-		args.chan.length = 0;
+		args->vmm = 0;
+		args->ctxdma = nvif_handle(&chan->push.ctxdma);
+		args->offset = chan->push.addr;
+		args->length = 0;
 	} else {
-		args.chan.vmm = nvif_handle(&chan->vmm->vmm.object);
+		args->vmm = nvif_handle(&chan->vmm->vmm.object);
 		if (hosts[cid].oclass < FERMI_CHANNEL_GPFIFO)
-			args.chan.ctxdma = nvif_handle(&chan->push.ctxdma);
+			args->ctxdma = nvif_handle(&chan->push.ctxdma);
 		else
-			args.chan.ctxdma = 0;
-		args.chan.offset = ioffset + chan->push.addr;
-		args.chan.length = ilength;
+			args->ctxdma = 0;
+		args->offset = ioffset + chan->push.addr;
+		args->length = ilength;
 	}
-	args.chan.huserd = 0;
-	args.chan.ouserd = 0;
+	args->huserd = 0;
+	args->ouserd = 0;
 
 	/* allocate userd */
 	if (hosts[cid].oclass >= VOLTA_CHANNEL_GPFIFO_A) {
@@ -329,27 +326,28 @@ nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
 		if (ret)
 			return ret;
 
-		args.chan.huserd = nvif_handle(&chan->mem_userd.object);
-		args.chan.ouserd = 0;
+		args->huserd = nvif_handle(&chan->mem_userd.object);
+		args->ouserd = 0;
 
 		chan->userd = &chan->mem_userd.object;
 	} else {
 		chan->userd = &chan->user;
 	}
 
-	snprintf(args.name, sizeof(args.name), "%s[%d]", current->comm, task_pid_nr(current));
+	snprintf(args->name, __struct_size(args) - sizeof(*args), "%s[%d]",
+		 current->comm, task_pid_nr(current));
 
 	ret = nvif_object_ctor(&device->object, "abi16ChanUser", 0, hosts[cid].oclass,
-			       &args, sizeof(args), &chan->user);
+			       args, __struct_size(args), &chan->user);
 	if (ret) {
 		nouveau_channel_del(pchan);
 		return ret;
 	}
 
-	chan->runlist = args.chan.runlist;
-	chan->chid = args.chan.chid;
-	chan->inst = args.chan.inst;
-	chan->token = args.chan.token;
+	chan->runlist = args->runlist;
+	chan->chid = args->chid;
+	chan->inst = args->inst;
+	chan->token = args->token;
 	return 0;
 }
 
@@ -367,17 +365,17 @@ nouveau_channel_init(struct nouveau_channel *chan, u32 vram, u32 gart)
 		return ret;
 
 	if (chan->user.oclass >= FERMI_CHANNEL_GPFIFO) {
-		struct {
-			struct nvif_event_v0 base;
-			struct nvif_chan_event_v0 host;
-		} args;
+		DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
+				sizeof(struct nvif_chan_event_v0));
+		struct nvif_chan_event_v0 *host =
+				(struct nvif_chan_event_v0 *)args->data;
 
-		args.host.version = 0;
-		args.host.type = NVIF_CHAN_EVENT_V0_KILLED;
+		host->version = 0;
+		host->type = NVIF_CHAN_EVENT_V0_KILLED;
 
 		ret = nvif_event_ctor(&chan->user, "abi16ChanKilled", chan->chid,
 				      nouveau_channel_killed, false,
-				      &args.base, sizeof(args), &chan->kill);
+				      args, __struct_size(args), &chan->kill);
 		if (ret == 0)
 			ret = nvif_event_allow(&chan->kill);
 		if (ret) {
@@ -520,46 +518,45 @@ nouveau_channels_fini(struct nouveau_drm *drm)
 int
 nouveau_channels_init(struct nouveau_drm *drm)
 {
-	struct {
-		struct nv_device_info_v1 m;
-		struct {
-			struct nv_device_info_v1_data channels;
-			struct nv_device_info_v1_data runlists;
-		} v;
-	} args = {
-		.m.version = 1,
-		.m.count = sizeof(args.v) / sizeof(args.v.channels),
-		.v.channels.mthd = NV_DEVICE_HOST_CHANNELS,
-		.v.runlists.mthd = NV_DEVICE_HOST_RUNLISTS,
-	};
+	DEFINE_RAW_FLEX(struct nv_device_info_v1, args, data, 2);
+	struct nv_device_info_v1_data *channels = &args->data[0];
+	struct nv_device_info_v1_data *runlists = &args->data[1];
 	struct nvif_object *device = &drm->client.device.object;
 	int ret, i;
 
-	ret = nvif_object_mthd(device, NV_DEVICE_V0_INFO, &args, sizeof(args));
+	args->version = 1;
+	args->count = (__struct_size(args) - sizeof(*args)) /
+		      sizeof(*args->data);
+	channels->mthd = NV_DEVICE_HOST_CHANNELS;
+	runlists->mthd = NV_DEVICE_HOST_RUNLISTS;
+
+	ret = nvif_object_mthd(device, NV_DEVICE_V0_INFO, args,
+			       __struct_size(args));
 	if (ret ||
-	    args.v.runlists.mthd == NV_DEVICE_INFO_INVALID || !args.v.runlists.data ||
-	    args.v.channels.mthd == NV_DEVICE_INFO_INVALID)
+	    runlists->mthd == NV_DEVICE_INFO_INVALID || !runlists->data ||
+	    channels->mthd == NV_DEVICE_INFO_INVALID)
 		return -ENODEV;
 
-	drm->chan_nr = drm->chan_total = args.v.channels.data;
-	drm->runl_nr = fls64(args.v.runlists.data);
+	drm->chan_nr = drm->chan_total = channels->data;
+	drm->runl_nr = fls64(runlists->data);
 	drm->runl = kcalloc(drm->runl_nr, sizeof(*drm->runl), GFP_KERNEL);
 	if (!drm->runl)
 		return -ENOMEM;
 
 	if (drm->chan_nr == 0) {
 		for (i = 0; i < drm->runl_nr; i++) {
-			if (!(args.v.runlists.data & BIT(i)))
+			if (!(runlists->data & BIT(i)))
 				continue;
 
-			args.v.channels.mthd = NV_DEVICE_HOST_RUNLIST_CHANNELS;
-			args.v.channels.data = i;
+			channels->mthd = NV_DEVICE_HOST_RUNLIST_CHANNELS;
+			channels->data = i;
 
-			ret = nvif_object_mthd(device, NV_DEVICE_V0_INFO, &args, sizeof(args));
-			if (ret || args.v.channels.mthd == NV_DEVICE_INFO_INVALID)
+			ret = nvif_object_mthd(device, NV_DEVICE_V0_INFO, args,
+					       __struct_size(args));
+			if (ret || channels->mthd == NV_DEVICE_INFO_INVALID)
 				return -ENODEV;
 
-			drm->runl[i].chan_nr = args.v.channels.data;
+			drm->runl[i].chan_nr = channels->data;
 			drm->runl[i].chan_id_base = drm->chan_total;
 			drm->runl[i].context_base = dma_fence_context_alloc(drm->runl[i].chan_nr);
 
-- 
2.43.0


