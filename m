Return-Path: <linux-kernel+bounces-886948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53927C36DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2522C6429CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9433555B;
	Wed,  5 Nov 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX2Oa+P5"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2B2F7446
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361070; cv=none; b=kaDajSqlBhIZ+Lu+ZuI/JGgv4MlQnUiDdEpHd5MLv7Bke5G+DCslr+1pSf9BIrmF7Ypqi0xGjh3KBTvuDYjTXtevm/y5r0VL4321owJ8APLetJAVO0ClFusU4PBgKDdk+WupKdNsfwrlYH/URPuEHg27Oog74rZDQ2KyeDPMcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361070; c=relaxed/simple;
	bh=ZY2ovksieRapgk658pHLWkUZACRChu2RMh3Rj1+1OEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7qJkj4IABX0v66u6fEyAhickClZ1O8zQHORxLbMOcRMS32u8CEX3y4O+3BHJwpn0ZGlBiSVSq+65yaYOhT4XEdaGZ4Wx8J79bvl6C2MWPZZKjEzxENSelWVMy8fAINxuMkPI55TirFPiZV7IV8gNSVp4NIugUA0lBPYf0qu9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX2Oa+P5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47109187c32so36333395e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762361067; x=1762965867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY2ovksieRapgk658pHLWkUZACRChu2RMh3Rj1+1OEY=;
        b=dX2Oa+P52D582kSPmWAJS4zi/TQZfKtlW8CoMjXjzJOUhoAyWmwGmQqz0mkmHUWT2I
         6isqu14x0eaMlmGZyxc1/MhMHZrrK5BmG8teolTy8NTKMxvRCkqAXEm1XM9YxuZTFyOq
         Q4qZneMEpfEa28Dhb8P9BF9z5/8/4IfMQu/2je3fXg71Ak7gGDg/Z81EdulCTShtLsgS
         hRttzsej++G0l++YKrq+gHiYfE+SdSdvFr/9BoGThIIduMQXGGZFYnzLXfUaX454LuEE
         42/+7kS76fs5uEq8tK+5FudhxqHff7deq97A3pMfFK98la/0jgIbgXz/1BrAAPfiBgGp
         CgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361067; x=1762965867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZY2ovksieRapgk658pHLWkUZACRChu2RMh3Rj1+1OEY=;
        b=Luz2AVyn1BG2s8n/rd5etVzvPJUuulllv2KF1prVl8AgfsQYaEnQ9swDTFcrpTgASZ
         GzF2qGLVmJIZ0u3V+DQss7++w7LhecId1xMw2yZYluZcXUDjmMx0AVPWScaFP2DknrFE
         6uhsQFoE3CuRKc8pgy1bwSOr6jUNWkARU8c5m1XarhL9Ob8B3WVhZM0RNwoXSheDH02f
         123A7kfsfeJ7mtAiXYXD+lEw0ZOZriDe76I50uMEyhzixLXxT2PuOCgUO8uSDElyVx96
         T+ADmAJ2qIx0K+hV/e77CzYuFnZTqGmP1fJRuVe9I74utJfjuU/N81oNRR6TikOKtIXL
         vrIA==
X-Gm-Message-State: AOJu0YzAh4/Pd7pDfboV5cyeiC0mbtxzpi/GXUH1FDBeFc6YbU7+lxc9
	zec8pFVkeMwZxgoLLJRuafrkKPTr7XaTON2lg/tZbqq5Nq/izIdj1sUI8OWxPg==
X-Gm-Gg: ASbGncv3EtqzOhE9ukUyj6NfYxn3nKSlgB6idCqKQWO4ZRhnYKyD8Q5+lOFtAewAwgC
	nIFwasj/HiRVP7bBiahoPobjp1pdr3VgBtLu4r3PNwaNZu06T33ve8SW9M7ClAmBhd1wHVNe4wX
	qqK+daX4Zrblpdh7ifC675d5tm7nQWJj+rXj2et/x8pAAyljj7SDBpD4LG2WbvFjuYR6ZU9lpvo
	plM07rWK43x1NnB8C82PlBs2/uyAXkOOS98l22cIoaBt2gLj8vCfCG7zeqYgmxcxFYSDNQPONtO
	y9JQ4iRpQNVYJQ2sBrNSYd2W92H2Mom+AYapihlj8y0JvbqJ/bhjppazRnZ3KNAC5oMt1x0/fVe
	BbTZ3zFI/uk7R6CpkcvZHF60Gg3OGyH7L9oTVSvQZ2xWLAmCUpDuqBpl2UYDZtBXS8i6hr+ogBN
	JGPhWvxw1aiNsCW5eLOqCtKNXddSTtPg1QLQCkujwY6ERVNg8lMJxAaVn5xg==
X-Google-Smtp-Source: AGHT+IGU8h8RqLt1fJTOpph+Kb6J+YXpLSWNisJ5Rw8ElaLdkndSmhqlDVbaDGVZcwA5Mkqog8YWaw==
X-Received: by 2002:a05:600c:1c90:b0:477:589e:6c2f with SMTP id 5b1f17b1804b1-4775ce1eabamr35876305e9.22.1762361066679;
        Wed, 05 Nov 2025 08:44:26 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdef7sm11938330f8f.43.2025.11.05.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:44:24 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko <mhocko@suse.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Subject:
 Re: [PATCH] phy: sun4i-usb: replace use of system_wq with system_percpu_wq
Date: Wed, 05 Nov 2025 17:44:22 +0100
Message-ID: <12772271.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20251105152023.259813-1-marco.crivellari@suse.com>
References: <20251105152023.259813-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 5. november 2025 ob 16:20:23 Srednjeevropski standardni =C4=8Das=
 je Marco Crivellari napisal(a):
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
>=20
> This lack of consistency cannot be addressed without refactoring the API.
>=20
> This patch continues the effort to refactor worqueue APIs, which has begun
> with the change introducing new workqueues and a new alloc_workqueue flag:
>=20
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>=20
> Replace system_wq with system_percpu_wq, keeping the same behavior.
> The old wq (system_wq) will be kept for a few release cycles.
>=20
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



