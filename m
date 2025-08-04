Return-Path: <linux-kernel+bounces-755346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE191B1A53A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3363C3BBF64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4BD1F4CAE;
	Mon,  4 Aug 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErICoXQj"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389441F461A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318976; cv=none; b=SWCdIY6qynI+AkWTX0QX+5TJitcOxUfgB2dX99V/bbgoI9SK+8GyjhDldlaMWAiZP0RRPnJm/HyUyOE0Tc/lLMRNc4ejTbVFB7nnAReoZH9PpVlsRYndKJNoxztBqhT4AP3lOL3koR7cChm5AE33D+64nAUdx3Qcl/Kzb/Ys91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318976; c=relaxed/simple;
	bh=9vsCKad0S7pssQeJzda8xSzGBjYedW5lmjIKowJASe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGDU0Vd6dORS1buei7oRaSX2+QZQqPYZgKK98JLj+LHEAkmYkl6SdLGdSpDROYo3onAj5pklvcu7Ke/BCgH0DH/sNkp+PT+ZC99GFoI9ZcS5shq48ROs9C76ta+d/IfqQRnxp3P9N7+KL6LRdw2x1x1Uq6ORJTW53cO5fENv18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErICoXQj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso4288383a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754318973; x=1754923773; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epoP8sq6ZzXGsjqp9Vf5bycC7krezH4J6H9syRshsAI=;
        b=ErICoXQjDftmhhkba6ekepJcl2fEpOG2g+sfPBpEOYUm+FccrsJfm6uXyJDPQGRn3y
         t4Ei/uPly04URwb9Yc7KWcSVKEq41/AvKiHv4+wNrrvHftehaGx6HdGrl4K5hdj07Liy
         L+x0IAAwad7K2dqcfX16vU0xOQu+m0AnKteIBLkg6sMDgtO3RlISwcQ7YXAyCL3ftg51
         2gSJ78LzrMmpklP5X7QCS3jtlCW2mL+x+kHanTD0TaAki8KJFRyB+bAXnhr2BpIuPUW7
         71kNYwaYMHP5hqPTVUJZBW9t/Sncc/orGIXhMca/cYrHhkRHG1f0CpTM7IpY9dG6vN6D
         d+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318973; x=1754923773;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=epoP8sq6ZzXGsjqp9Vf5bycC7krezH4J6H9syRshsAI=;
        b=bXoO7lfuTA3v4od7xsNUSxiby+YW4eTkBUT6D+mbfSMZPXnInSmhR9s787xXo/Gjp/
         HyMkrRVcqvY/Jva1wIS6jPvzty3EVHke1nIEur+J7Y92H8NdYLcXchR8MF7umXDC4/de
         2EVZgBh3gFNUZSp/R86q3wYgG3rCunhYL33Ozs42TkpvQLrjGBTZCwQ3yTbRaBAU28ez
         7w9JJODzfPele2pwWzuVytEvboMtz0dOfVE1FZywdfVU4frDdbsnnsBLVxax96RodiAx
         UovrPTWpZB6+jo2TlSWfUzu2NffQiKQweZNx9lPt0r5gOMQk+ZMc8tVyVKNl7fSfdXoO
         7TxA==
X-Forwarded-Encrypted: i=1; AJvYcCUeUC97/+GKMuGtw33IN2jFDZEHd4iF4vtIC1AnU43uT2yGXZEZXB1tgjvp2VkBDiMK6OkKT0zUUDtJZ0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhEmnWtaTM8Hn+m96zTSVoVbfQtQFfA+Vpdt8NbkZwFrLMH94+
	QdemcAaa5G5OvNwxviwKdpYTs0zt6DeLivIBUziD6D0rpGOc4f0Yd2ix
X-Gm-Gg: ASbGncsjivVUfFt0jNoE7Kd8FlffZVI0h23uXH39AIMM6TVZ7e1XToxuufbQShg1mlE
	fOos/y51QxFla4kU3IdxeL1wiyJ8uLd+B1mKAcILbkTmgiCCCbk/+JfO0UHMGJlm3QzGsfoLpcA
	1EN51oFbQHu2dUraNOGhF22TJ2zr01i8hVeY0xlQyZS+4phyLwJ18aHKwCHRMYuIN+FGh/hmr7y
	qUDKpNSdClFvh8oP4VryklzHpAC0ESq2BA4I7mv4mY//OjRRht42Bekmx7UTkGeRMSN5H8kV+X0
	tgrljIpxZ3OMir/xuLU7QHhR97ltLmEeEovZUKlGpVquGY0S7cz64OgORbANELmYYuWiZG21e+c
	2QQLZ3m+/lNHO9Gtivr5e3A==
X-Google-Smtp-Source: AGHT+IE2ci4iWmrg+FMq6iRk1evDI6e7iUTGKuKN7nRWDwdgN7sB8puNaMWxbs4XMQyR0gfQKmvWoQ==
X-Received: by 2002:aa7:c855:0:b0:615:4146:72c2 with SMTP id 4fb4d7f45d1cf-615e7178341mr6838033a12.31.1754318973213;
        Mon, 04 Aug 2025 07:49:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffb8d7sm7036966a12.47.2025.08.04.07.49.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Aug 2025 07:49:32 -0700 (PDT)
Date: Mon, 4 Aug 2025 14:49:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, willy@infradead.org
Subject: Re: [PATCH] maple_tree: Remove redundant __GFP_NOWARN
Message-ID: <20250804144932.dv7zhlr75ia6il3r@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250804125657.482109-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804125657.482109-1-rongqianfeng@vivo.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Aug 04, 2025 at 08:56:57PM +0800, Qianfeng Rong wrote:
>Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
>made GFP_NOWAIT implicitly include __GFP_NOWARN.
>
>Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
>(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
>up these redundant flags across subsystems.
>
>No functional changes.
>
>Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

LGTM.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

