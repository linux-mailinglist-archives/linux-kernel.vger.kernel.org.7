Return-Path: <linux-kernel+bounces-720765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F6AFC02B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B541E3AAF16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A0BE6C;
	Tue,  8 Jul 2025 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MTKRjkVo"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745520A5DD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938998; cv=none; b=V+CkdcL4IVO+dCL7kU0aswF5AqctV9rhQlRL0xsTsXBGS9IOtuXEkODFhqA47OhtK5zlQ8BaccangbQ1htxlPf3CiaRqbpiZCzgFUj1VhgkMknrCyagHCBShx0oZwImpfa8/5Y9lDw4SR91W4J7qqddI6bQhmUJq50Q8wl/HnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938998; c=relaxed/simple;
	bh=oehxuF0rpRqMYrksiPeKjhvWK2TzZ8xWgXQano59SuU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gbLFERWvEUStalPOo0LYFtDqvjftIuYec7zOVfhJtJHZwjqmsViP6pFlqFPdAcY0ZBDv0ohS00+qWUxMtscwjUYM5GEOBXXmUb5M4ctdZnmBOw5q+gqhVlxzjoYsGZ3ff8+nUA/L8ZxZ+hYKjaNp8oNzyZrSyCSlQ0xz4P8pdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MTKRjkVo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-749248d06faso3100614b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751938995; x=1752543795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qqal9dJWtuij7LcVHZxNBBp3o4uzMfjhiOgYU4J+uSk=;
        b=MTKRjkVosuFpfe4m/pDl/l8wROT7TzPr98h4AbTxPJn61fWIrJPnjmgl0vpJDGCtnJ
         bCPxc+BZGfMfwpjYqp3JQcN1/eqss62vgForBBtlFrjtaRzXX8numNs6GVxx1aYofN1I
         L/5dOM0A9l7IPzAjhFv2cilIdhonRXuojyTwTZ466koU13rOFAQKH0kvxEp+qJEY7fCX
         3Nv/WovloslFsx8fUfCib/CPPdIQUy/nK0L/SlegQ2QajFmCihMW5CDcbjUKl1ABOTt1
         +YVrl6IyPceoqlfaV9wT6IYERw1m19Pxm58DqT+YTn7E/zv14FtwzPafXUCSWGMwoJLi
         PVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751938995; x=1752543795;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqal9dJWtuij7LcVHZxNBBp3o4uzMfjhiOgYU4J+uSk=;
        b=BVk5VYFWJ9A5aM5IrG6u2eJLl6fq/vgLdLV1Nuz0oQVkQtGL38X6AVZp5Slrx6OL/O
         PC/FBsF+Qu0SnAlFV0dkPbay4pDb6JtIDz4J+wGT5GgXb4tEaS1ZQN6gC4F/8mPhX1mW
         BxQlvIgXjqE98JkmQ9SCxFbGXAmEubkGQGbVckUkgkrjYJm/rOMUP9iDQGm27Ak2erwP
         N2dgMH4Ge/oTQxQlbJKNH+vfsAOQGUuHvaSZP2aJ/KkZq9KXBp72f2bH3uWCmGRt3tYe
         DUWP8Z4aSNj7zXYnuGFTGEfM7zY+P3NaeVpWZFPcvZNvCEQrb43eS9LmLkBWE6xtm84k
         Ampw==
X-Gm-Message-State: AOJu0YwsBAnQKkZ7DHj7VhIVO5Gn+lvdh1Pub+8ellxwnBAhfl4x12MK
	BVFOUMzEei67wMjjJ02/mhwbSJQAdXQH+5EE3ALwQHAkQsmMOaMLMIj+c26iixdYVno=
X-Gm-Gg: ASbGncv42zn29Zjx3QFIVj+Ps03JreMENLn6SPw7uQ6r+D5qu+xDdmz3HdBHhpJYTLC
	S7tpXEzSt6ov7jpIKTDVnzgIwkkYjpIV6kq0PUrwycGpDSY4RMFu+63RcnF2ZHLM+h+PGfwg3qi
	qQpn/RpMYW6irp0cjSL7RrfnGVw+d09Vevg5DyjJFwnhi6s8sMvYS/zwH2CFnZvd0a/aR/RVwdX
	rVOcp2CDV92CE7DAkkDZOnJrK2GW2cm3p5SHq5otKrxYdGycgjqMlWKoutqsGrZjsRUkgv/cgJt
	YLUshPwu6l85kVFGJlVGdNKRCwgnj04kHCbJQ5ImS7g3V8siODXiLkTnnKbuToCm702a+xJjkUh
	h2lNMew==
X-Google-Smtp-Source: AGHT+IEguwANQUifdc2EzJriPOiqglhSGmDNCPoQuEjyb1sZUfdDjEp80OMEXBAMzcrf1dXaSc7idA==
X-Received: by 2002:a05:6a20:6a15:b0:220:b0dc:24f2 with SMTP id adf61e73a8af0-22b441b01d7mr2280169637.34.1751938995141;
        Mon, 07 Jul 2025 18:43:15 -0700 (PDT)
Received: from [10.74.29.59] ([58.250.106.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f060165csm9919384a12.10.2025.07.07.18.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 18:43:14 -0700 (PDT)
From: Liangyan <liangyan.peng@bytedance.com>
X-Google-Original-From: Liangyan <liangyan.peng@google.com>
Message-ID: <33834852-af8f-451d-9a39-8787330c2694@google.com>
Date: Tue, 8 Jul 2025 09:43:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC] genirq: Fix lockup in handle_edge_irq
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Yicong Shen
 <shenyicong.1023@bytedance.com>, ziqianlu@bytedance.com,
 songmuchun@bytedance.com, yuanzhu@bytedance.com
References: <20250701163558.2588435-1-liangyan.peng@bytedance.com>
 <87a55mlok9.ffs@tglx> <f3608ef2-1d9f-406c-92f3-fa69486e1644@google.com>
 <87o6u0rpaa.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87o6u0rpaa.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/7/4 22:42, Thomas Gleixner wrote:
> 
> So playing games with the unmask is not really feasible. But let's take
> a step back and look at the actual problem.
> 
> It only happens when the interrupt affinity is moved or the interrupt
> has multiple target CPUs enabled in the effective affinity mask. x86 and
> arm64 enforce the effective affinity to be a single CPU, so on those
> architectures the problem only arises when the interrupt affinity
> changes.
> 
> Now we can use that fact and check whether the CPU, which observes
> INPROGRESS, is the target CPU in the effective affinity mask. If so,
> then the obvious cure is to busy poll the INPROGRESS flag instead of
> doing the mask()/PENDING/unmask() dance.
> 
> Something like the uncompiled and therefore untested patch below should
> do the trick. If you find bugs in it, you can keep and fix them :)
> 
Hello Thomas,

After over a day of testing the patch, the softlockup issue has not
recurred. This confirms that your patch should fix the problem. Thanks.
Would you consider upstreaming this patch?

Regards，
Liangyan

