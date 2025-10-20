Return-Path: <linux-kernel+bounces-861335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EB3BF273A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42C084E2D18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9613288C2D;
	Mon, 20 Oct 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZzZ1aWf"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44724168D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978042; cv=none; b=Ed/lPbliolAdgBYpvZD8gcEf7xqAJbOAowT/YD9DoGWjQGS+yviNL1eR0JtPQB2IN6MzeucC0DpAYxqFaI5trtGX3XIf2TvngrPbgnHn8ScrsblAiz3wkPqGZF3lvE5HmB72JVsKcAxJ8fKgGrHFvcN6ubsq/ncfq0WO8PWZVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978042; c=relaxed/simple;
	bh=Y5CEGs0t9LeXRLRCfmnRV+V4yK09SUomkNMkTtKhZbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YYi6eUxwY8b+ON0hVDGeLJUCOeFbY3uUXgNEWeZRuSuMwJ3tSE+0eCetJQLk8piACldxmm8BZpFF68SRmdANnUxtkaS59MbUWFm4ZztEusM0Pf81MqTc2woKlBM688Sv4abF+j/7/z2Cj4nJRV8HSSPq0YvYjnlIC04MiNBXkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZZzZ1aWf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28973df6a90so44955555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760978039; x=1761582839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xahSst9CglR2qFJe71Is8QVBM1v0GjyVtyRULSD/218=;
        b=ZZzZ1aWf/BGewykJ8Q9qUGbrPQukcfrZt0B02Oi8ff+QqNUVMJQjYsyy2eLUcNCzQ8
         5HUHH6CiSmyRtZ4EDVYXBa8dFjApSUowuVUgYXjV5bacbe9dO9RyDPv+JF9nclfLqqpt
         IdfMppAP9uIeK6GMJU96xuSsTC2AeCDaNma4X96UKPETy6Eo64osK422sR8SRSNNpf4o
         Wyc6s1n8stoxlJWqlLQqkgniG8OkK33jVGq5LqE58beJO83LfvVx9gUmnwB/GKNMBo2t
         yOXseyiy1R7ee9Ng53rEj6jUciJoh6UWzoj6MbOaz7+/qxUoVKU52BrbMv6wW0qmSAzn
         LY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978039; x=1761582839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xahSst9CglR2qFJe71Is8QVBM1v0GjyVtyRULSD/218=;
        b=gnY/mOTpCZXvCDfuNV1XSY+aWZPtaWYCfrhEuv7mdy/pQcTxnTGntIyul8hHsHo5Nu
         BLnSvCnINQOQy8hOFmm3Bo2vPkj+f+Ybk7385tw2NsuLfoFe+qWtmXRgR0hfpBHoa4Cb
         8n5shbl3gpdGeebpxw2nS9dKO8LTyvwM3wiUKuFkhBJHOr43xJyNfGl9nmWY/z8ACuE3
         4qvYJuTXDHB3bRsDgIVzw31fLDv7pFcNuXYUD2IZGqZT1yZT3BFDmzXPMDqa3F2jAtTt
         GWqnPb7n7yq+YjYzoMiS8avxVlazGExYJLfHBDgL2RCJF/yc6+75AwGB1x4LTsyFVkvS
         i3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCViiAiVemzMYe3C9fAE+3EfMeKDhDcjjThAdaUuY/PL69wpH8NzejZIy+MtNB9MdmD3LNrCYXVzaoiKDAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzch7e4FrPpo3yJvipT3G0tGhmQJ1EAvUUmEHH5TF5MG9qkKHyK
	n83LzUAn86W66Jh2mymuWrCY1TAlmBWHG9dqD0lE8nKt0vb2HbJA7u9YKxxV+BpxbqTQFfyLDTY
	cFz/Q8g==
X-Google-Smtp-Source: AGHT+IGz3l2nSx5AlR6WsV3KMbX/iOTStifDphqigGBgItnK5hyzgl82eH4fn8NCfPXntYDzW0XJZScJ2gU=
X-Received: from pjbgk9.prod.google.com ([2002:a17:90b:1189:b0:339:ee99:5e9b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db09:b0:290:a3ba:1a8a
 with SMTP id d9443c01a7336-290ccac6d3cmr177014055ad.53.1760978038920; Mon, 20
 Oct 2025 09:33:58 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:33:01 -0700
In-Reply-To: <20251014152802.13563-1-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014152802.13563-1-leo.bras@arm.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <176097609826.440019.16093756252971850484.b4-ty@google.com>
Subject: Re: [PATCH 1/1] doc/kvm/api: Fix VM exit code for full dirty ring
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Leonardo Bras <leo.bras@arm.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 14 Oct 2025 16:28:02 +0100, Leonardo Bras wrote:
> While reading the documentation, I saw a exit code I could not grep for, to
> figure out it has a slightly different name.
> 
> Fix that name in documentation so it points to the right exit code.

Applied to kvm-x86 generic, with a massaged shortlog.  Thanks!

[1/1] KVM: Fix VM exit code for full dirty ring in API documentation
      https://github.com/kvm-x86/linux/commit/04fd067b770d

--
https://github.com/kvm-x86/linux/tree/next

