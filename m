Return-Path: <linux-kernel+bounces-893602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1DC47D39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2F21888971
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DA327B34E;
	Mon, 10 Nov 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ab8K8VWU"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76810274B35
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790689; cv=none; b=Xwksk4gQB8H707Jp6Y1d9lIJdQeNvEwCB4hHMtZjjNZYBLoWqTX1JTNZW65sYPkC/2OCEXtkOaH6273kxSWgoQPVSY9FvDXobs+upT89K4b19ZzIZvWfe2MVPYaeoObeRxBK26CQM+VjSn9ogESmBUuDRDl/hJYUMcP5Ep1imsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790689; c=relaxed/simple;
	bh=xsCQeyVupDZ70P10hcuA2gENJ0NgW9gpLTOfi9ZPS6I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=p/fIFlTK6KP2NSjuHBNY0IYQdbzEAnyclqcppSwBlrOGAs2tp/0/YewMEDh9xg57SwM4/px5HryoI6FHZFwjaafVv4WSZA+Qn0BqSR2gLQRidxKaj8cKaG6pX01yVzVckNLGw7zOyKBHgxK+aAkcPMn2b6SbPvo+erLDxUGKqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ab8K8VWU; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-43320651e53so27166395ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790686; x=1763395486;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsCQeyVupDZ70P10hcuA2gENJ0NgW9gpLTOfi9ZPS6I=;
        b=Wl/J0BE7tOptXTtpeVM/r9U/GKGzS3zviH/QCorkBcTfGZs1fkTRAofMeuDFW328eY
         Xt/EL3gEzBuqOX819iHjFVs9ZOnKn61CUYPqPkfjZFSCUJbjD55u2PIs+OQK81c8xAA4
         dpluLLUq4wE+/e8cZh4eJVX+b2FGqz5UKmw9CcNpMH5UCCF1wBE5t10yPLbrluA1ENj7
         yo23sokZFnkyvJ+xTWfnzZQGKQXA6sDKPUaCz19xfRXOoKdSvJjolTzSKRbx8zI9KuDI
         2jjDCS6n+O5HaBzTIegKjD7fGBmwq5uF268t3Uf4fZW2MIvW47Bp/xZggNvHxCqPC5+R
         Aj1w==
X-Forwarded-Encrypted: i=1; AJvYcCXfKgBiEcF0OP2m6PNoKwgRi5r5P/0uaIGdNRkwWWqnKQshcIR+se0giuP+PbFgKQI4cTiuCSRMDcBDyTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgcxg50A0lK1T3/lL1MVhJ3/QsC2mtkcLo0nSb2cxQTYobBdp
	MIaeAzJcVk0f4RTPeNw7sVnUZFiodFHMEmjrj8P8DpkKu8jP/2bj4/qXnIAbsbsUoTWS6wHH01P
	ceTEp6kDpont7NnN2K0mhOd2I4XhqWHXnoGytcdsEpuwvHcdu23ONwL+rma4Yos848b1V/mDZMI
	THJj4k6YMt6Cfmux2QMYOmPUVXybexBcGLtljVDtpfLWqEEvv9LwDZ1Xug+stqTC/liAj+0u/OL
	vd5Rpno3fiNBOS6IqWS/UoQ
X-Gm-Gg: ASbGncsOrWfP8u9DFm5Uz8M7M2KoBNVQLxxC+7AcMajSmikpx3CMNksvBrYliwY4oxB
	0OpcrEdy2XBzIpG3i5BHalBln1l/s7pBKM2i3OLel1MNgJW+iY+NuFoPjc8AuX7k72dDWYtOpa6
	Z+eCzOsdmwvU5eWApqAzz6twpaG2e8vwsxoSMbNMQg2cIG+odC4GPJb2Cm2aspzKrYujirKHk1P
	996T5amJ2pgoWFoePhoJ6qvlNK3FkavlXjMv25AQOIyt5P/MJvrwUIUd4BLZuKnyJUDbY75VaZY
	pMrIHXlg1AjAZRFTOmBFp2NxNJSGYgf2k0piOC/ov9nI9zgpO+VgqYW/ri6t7r/LGdXD4UG5Uy3
	x9SmrDU9Xgbn5Y3lcn18Wz2eZSp2j49SwgF8OFRCDzCpyHVEG7FTHfVD6Qb9xkKWNuH/t3y1ceB
	4/UtYYFcS6F2tvT4AOnOp6OVMWixDtcUtFVzc0qv7cOQ==
X-Google-Smtp-Source: AGHT+IGine6opEJ4RVBx2ZtM1bxOsZvM39rFZ9TwtN+NpTiPwUC0b1XmFYlqqL/x/87Y+85y+KNjwbIy5i0t
X-Received: by 2002:a05:6e02:8f4:b0:433:6f20:32cc with SMTP id e9e14a558f8ab-4336f2035f7mr81137685ab.16.1762790686497;
        Mon, 10 Nov 2025 08:04:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b746739ab8sm1401983173.6.2025.11.10.08.04.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:04:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7aa440465a1so6164610b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762790684; x=1763395484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsCQeyVupDZ70P10hcuA2gENJ0NgW9gpLTOfi9ZPS6I=;
        b=Ab8K8VWUF5lFwcaG39BN5HRtuy9WBb9T70SvNmz4gmr7sHFpvzg+OKkemTCI5ZWjHr
         0/Lpm0iinaZ3b2lw29bq11wI8hJj2eRT8u0FaP0gVIbV7EHdcHoGpmGj/HVLDMleKwQY
         Z0jILx8VfyBykGbgc9/tKj8QhSZ5zRrhHbQgY=
X-Forwarded-Encrypted: i=1; AJvYcCUtolVk9+2SqjuKA/Iy0MLZpqg2dap81NHi/WOm0298nWiydbahfGkA51fpG1fwMn3D6a2lbz+YUlo/D4w=@vger.kernel.org
X-Received: by 2002:a05:6a00:bd83:b0:7a2:83f2:4989 with SMTP id d2e1a72fcca58-7b225aea11cmr10247681b3a.5.1762790683949;
        Mon, 10 Nov 2025 08:04:43 -0800 (PST)
X-Received: by 2002:a05:6a00:bd83:b0:7a2:83f2:4989 with SMTP id d2e1a72fcca58-7b225aea11cmr10247634b3a.5.1762790683437;
        Mon, 10 Nov 2025 08:04:43 -0800 (PST)
Received: from ehlo.thunderbird.net ([2600:8802:b00:ba1:b6a4:5eaf:bf66:49de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e718asm12233192b3a.30.2025.11.10.08.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:04:42 -0800 (PST)
Date: Mon, 10 Nov 2025 08:04:38 -0800
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez_Rojas?= <noltari@gmail.com>,
 Vivien Didelot <vivien.didelot@gmail.com>
CC: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net=5D_net=3A_dsa=3A_tag=5Fbrcm=3A_do_?=
 =?US-ASCII?Q?not_mark_link_local_traffic_as_offloaded?=
In-Reply-To: <20251109134635.243951-1-jonas.gorski@gmail.com>
References: <20251109134635.243951-1-jonas.gorski@gmail.com>
Message-ID: <BBB3B106-E173-4098-A90A-3A75C2C545B6@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On November 9, 2025 5:46:35 AM PST, Jonas Gorski <jonas=2Egorski@gmail=2Eco=
m> wrote:
>Broadcom switches locally terminate link local traffic and do not
>forward it, so we should not mark it as offloaded=2E
>
>In some situations we still want/need to flood this traffic, e=2Eg=2E if =
STP
>is disabled, or it is explicitly enabled via the group_fwd_mask=2E But if
>the skb is marked as offloaded, the kernel will assume this was already
>done in hardware, and the packets never reach other bridge ports=2E
>
>So ensure that link local traffic is never marked as offloaded, so that
>the kernel can forward/flood these packets in software if needed=2E
>
>Since the local termination in not configurable, check the destination
>MAC, and never mark packets as offloaded if it is a link local ether
>address=2E
>
>While modern switches set the tag reason code to BRCM_EG_RC_PROT_TERM
>for trapped link local traffic, they also set it for link local traffic
>that is flooded (01:80:c2:00:00:10 to 01:80:c2:00:00:2f), so we cannot
>use it and need to look at the destination address for them as well=2E
>
>Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
>Fixes: 0e62f543bed0 ("net: dsa: Fix duplicate frames flooded by learning"=
)
>Signed-off-by: Jonas Gorski <jonas=2Egorski@gmail=2Ecom>

Reviewed-by: Florian Fainelli <florian=2Efainelli@broadcom=2Ecom>

Florian

