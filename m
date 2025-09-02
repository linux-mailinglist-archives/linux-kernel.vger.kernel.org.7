Return-Path: <linux-kernel+bounces-796711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6807B40635
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E682172211
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A42DAFD2;
	Tue,  2 Sep 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tw5lNN2j"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E142882DC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821857; cv=none; b=KzrPiceYMSZ1pNWl30SJ18ctkn6f4uxnOBz6aIJTxmj7zgZ9zQwxWjAhsKlL40l6MQTkOa+e74umus+JbCO0rEXL2VgUhoHEH9U5/DWBi1QBUdy7pGDJFXrqJkHRRkWg6BLPn5yd34MigpuA+Ig7N7fjSZi0oim7QLANNINxa/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821857; c=relaxed/simple;
	bh=vu2HQxGlgeT6oN7xu9V/ajIxDf4r9TunR4a+QydcYNE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HLgnLctKnCf0A+lNpy7XhP8xabTTqYJVEvThc0Y53P97oIjiLy3jKgpMIdETsOSoulnNDAKCnezN2Fg447/6SPCKHbTn3zdTK/hr0S1W5N6LyW0SbpcnYzszbFlTQyoEzj92OudJ7zvH5ENZqQZC0iz8Wqh30whXv6WsQhFgQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tw5lNN2j; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c1aefa8b7so4383765a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756821854; x=1757426654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu2HQxGlgeT6oN7xu9V/ajIxDf4r9TunR4a+QydcYNE=;
        b=Tw5lNN2jO6VJgGtqgw/yOyXXt8SQHZn0HkzFyOUZ+XJbc+kMZOUsnRXMSHBNER+/vV
         xVE3XcHVwS0beKRFo9Op2ifUMcY6+okojnaXRBIpryQsfJB6PYhr5QsFJB2mqAqYYwNj
         QF3IeInfjBj4xSoUVb/R6yv0PINVBaQMAm6hHbGlVCEVgAnbEielAqRWij6FLycW5EZ3
         TVIcpEcy9avFTrpfswY8A+nbhhomcqKxOfEMtTliQJTnuNI156N3aivPMS+ntFOwUtle
         8ogql+mxe8JZM+ClwahPqvh+oL+PRFGKsTbUeBKz+yQQxplOfRGZ3tl8jEf59/6TErJT
         Ovfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821854; x=1757426654;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu2HQxGlgeT6oN7xu9V/ajIxDf4r9TunR4a+QydcYNE=;
        b=qMGG5XWS3MHewVRJJGhFb0PUb2QxNQPknz8ct3DLdCqFLC9xWy7/PfM5JqhgRnHPuW
         hXPVnwHKX/LpGQq9kJ3RWMsen+gzLC2oSY0mcu+e95O9lxGnyrB3ubt+ZOylBcTpaPqY
         2/iT5YA335aW6rMzocsimc2LZgBgkbFLwVldSlJTHcctUNpX8P218kfeUOGG56LV4ihW
         6g6uoCYmOQbHKasT+JNj5tat9rWv2c8m2tAFXBpXDzgYXsXunBiQr3rzoEfkyd5te0DE
         LHI5AW/hntmi93kbVcC7pv1RwMOpkMRVCiDx0DaNbU2ahnAeGCfuKzNCzu8dy7B8x6Gx
         QTCw==
X-Forwarded-Encrypted: i=1; AJvYcCUwI05+X2QDnV2POJQi8YuumsCcT3KyjGRsZlPiHyKmTORPbOMkuBF0EU6YcArgYctAuh8lH6Kg6RdcIl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMMf/GwyNIULaMLkqWI4qgFAo2MgegB8jq/sU6S4aGVRsLHy3
	zQzb+NqCQei/eOgpJSXoINewi3iIk2hDsRrau2Ugtbkm8SDo7CdomypS8T5ADy7gxkcpLECWnQp
	G2o2KXA==
X-Google-Smtp-Source: AGHT+IEhYHWyEv2iGFE7S8whDqklOJ3pfudKlua9N4/l+AJnSyMHa7uiBK2WYOTsoIAqfmbSxx8OxMWI0KE=
X-Received: from pfbcu14.prod.google.com ([2002:a05:6a00:448e:b0:76e:396a:e2dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33aa:b0:240:1fb6:d326
 with SMTP id adf61e73a8af0-243d6e009camr14954272637.21.1756821854596; Tue, 02
 Sep 2025 07:04:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  2 Sep 2025 07:04:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250902140407.474538-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2025.09.03 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No PUCK tomorrow (September 3rd) due to KVM Forum.

