Return-Path: <linux-kernel+bounces-859886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A5BEEE34
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C0D18958C0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049A3254841;
	Sun, 19 Oct 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmRJRo7x"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92531514F7
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760913036; cv=none; b=IhZm457+d3dP/EswAgfnzzQtCJqa1Nzbtyvn5jn7aGleUnMcYFS8iEe8HD5BBItd6JX/haaOecSi/EZzCoyS9hVtz+QTvnP7kiKEv2MtlgflgHzbljJBsqFzHHUOevnYIbuk8zVNqEqXVRx8ZAmubNlnMZ+wAhvmBQRsWfkuK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760913036; c=relaxed/simple;
	bh=1VyNDB02vhSBB7FEJy9+MvvYx7rYtvfZUUI8FZN4GJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prle4shSIPs5JoF+vQcFAHXxFpe/+67tjd7st7n1/kjc2e+dQW7EMo4OECWPy+j9PB8p2u4yuE9Zn37gbKqWcC36PZZSzrV4BoSS3Gi1OiWv9tfERZhEhAlkQdGqIdLjH20HBQU9l7IZJrFbomyDk5nLHGM4595BT7uAtPOqkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmRJRo7x; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-79af647cef2so3247761b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760913034; x=1761517834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln/mU8zYFji5KHoiExwHL0rc07J4kGX/OgUlOJfH7cY=;
        b=CmRJRo7x4ybiQ7OHOHM6xIrmEy6zDXiaLy36OlN+GwEsJq+VulIed5YtVGfvTOmNDk
         1kGqqJ/vnb54lG7af3QVBMVaFTQtiKemyuYEUAREci45iUYnw7qWYkjGPXGZG58QTfWm
         fVXdWXn37EZqnWGhbBkvo536q2fRBYfR6s4L3xcR6eVVtiCvpval2wra0UKRFWk3vQ9U
         A4qn8kd80D5DBByDNYX0JzPoJbn0UQhFR+Knu6SgWc+hSOztsgGh16wgHUwCrXb448Jt
         zJGXmF7fkY87vAgPs4nHt4xRHava7kYuWAR0WwHUC6WNr+DX30RdnJxwv8By+fG/UjJ1
         Tbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760913034; x=1761517834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln/mU8zYFji5KHoiExwHL0rc07J4kGX/OgUlOJfH7cY=;
        b=h39O3ZgowF1rWnnh84lYJXtyMXWbLVh6nYBq/DGDBJpNUXFUCq+qvH3su9opX53PHZ
         8zSXBiyWbu+NbnOp3L9xe20LLpLS9b3wzdgpGgxQHvsrGAcBmNjCktvMWCNr+Cz/dVYC
         WYzLx0LOEfl08oHoIm2jtB1jMzG0Lu0fbV7EOiwR2wnoIG+843dUoEYStqXXMM/dKGu7
         uwFuPtSPkLZ8Ot8rtOiYbcr3ihfCAhZwZi6jBMlBJIA2eNgDvllWu4wSeIBNl65HrCZR
         sd9dhCO4mheuc/ODOta55yPTtnw0sJ+MzmKUHm2xTXkeXqfuV5DVKYWC2tQcoq5+FJdX
         kCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs2KQZO6K8j+XYQuVc8AZ6hYVQX0als2A7ULZSB+Mg3SprJ4ht1BFtbMJrKcOYQZuHXwqlh5hpyF7C7tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnAvvixA2CzO3Et06XvYmA6nAPYq/LuiKYOu4Lc72vE/xHUMw
	4lXcNjj59tyK39w9RTur1ALW+HNUDugPh7zME0gXo6txR5STN9dZUnoP
X-Gm-Gg: ASbGncsyJ1hCsWQv7ERIhlJZCgtns3ljNUwRx4rgKz78JalcABK9/sIflTs3b6muJzL
	xNqrGLaeNPtpjuqEbLxArbc4djgJYucNUfV2ldIU4XdPf0SkyON591SzWFv5d7B6+RgwYqVjTtT
	8M6SK+gd4j1CW2sKuWCmgMC4DNZMPoPWC2M6wdjFVY/bJpH6Q+ef8SWG2YssDqVJ3V7lKqkic/B
	lpJOtfs/xMfBpvjVy2Beq4aKBi42GyGYx3a3RIqmtZI7CheaK/LJLnvttQGL5vg5t6w8UC+LdQq
	p0QBuNB0jLvNZedLK/TQYzoUeHITyOpzyfkKtkWAWLvSaaVjYQB9uuJarpeY/cYN+dv5FBUDIyU
	XHkEWf4bCmttR1kWvSaSfpr+glSXSvD6oRNFe0rm0cp4y6C4CNCmaZ8j8vDret5SEbfPnG4hd
X-Google-Smtp-Source: AGHT+IGnF5Srcir7/6CWxen50eglfngyYXHZEDVZiPbz8BkFINxUwaCDRPwDVsgdeNlWE25tkflYZA==
X-Received: by 2002:a05:6a20:6a1b:b0:319:fc6f:8adf with SMTP id adf61e73a8af0-334a85340b4mr14174653637.12.1760913034079;
        Sun, 19 Oct 2025 15:30:34 -0700 (PDT)
Received: from fedora ([45.112.145.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76645c61sm6317715a12.3.2025.10.19.15.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 15:30:33 -0700 (PDT)
From: Noorain Eqbal <nooraineqbal@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	david.hunter@linuxfoundation.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	nooraineqbal@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	song@kernel.org,
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: sync pending IRQ work before freeing ring buffer
Date: Mon, 20 Oct 2025 04:00:06 +0530
Message-ID: <20251019223006.26252-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAADnVQ+pXhEsumx6NapCU0sCJw9vdB3TdLMLtCoHa7_sqCRH1A@mail.gmail.com>
References: <CAADnVQ+pXhEsumx6NapCU0sCJw9vdB3TdLMLtCoHa7_sqCRH1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 19, 2025 at 1:13 UTC, Alexei Starovoitov wrote:
> Why do you think irq_work_run_list() processes bpf ringbuf in
> the above splat?

In the syzbot reproducer, GDB shows that when bpf_ringbuf_free() is entered 
the ring buffer's irq_work was still pending when the map was being freed.

    (gdb) p rb->work
    $5 = {
      node = {llist = {next = 0xffffffff8dc055c0 <wake_up_kfence_timer_work>},
              {u_flags = 35, a_flags = {counter = 35}}},
      func = 0xffffffff8223ac60 <bpf_ringbuf_notify>,
      irqwait = {task = 0x0}
    }

Here, `u_flags = 0x23` indicates IRQ_WORK_PENDING and IRQ_WORK_BUSY
are set, which shows that irq_work for the ring buffer was still queued
at the time of free. This confirms that `irq_work_run_list()` could
process the ring buffer after memory was freed.

On Sat, Oct 19, 2025 at 1:13 UTC, Alexei Starovoitov wrote:
> Sort-of kind-of makes sense, but bpf_ringbuf_free() is called
> when no references to bpf map are left. User space and bpf progs
> are not using it anymore, so irq_work callbacks should have completed
> long ago.

You're correct that normally all irq_work callbacks should have completed
by the time bpf_ringbuf_free() is called. However, there is a small
race window. In the syzbot reproducer (https://syzkaller.appspot.com/text?tag=ReproC&x=17a24b34580000),
the BPF program is attached to sched_switch and it also writes to the
ring buffer on every context switch. Each forked child creates the
BPF program and quickly drops the last reference after bpf_ringbuf_commit()
queues an irq_work. Because the irq_work runs asynchronously, it may still
be pending when bpf_ringbuf_free() executes, thus creating a small race
window that can lead to use-after-free.

Adding `irq_work_sync(&rb->work)` ensures that all pending notifications
complete before freeing the buffer.

Thanks,
Noorain Eqbal

