Return-Path: <linux-kernel+bounces-588603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D3A7BB1F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 12:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9028A3A9D59
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35C1C5F07;
	Fri,  4 Apr 2025 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWM3dtwo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA2B672
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763353; cv=none; b=tPa2CFckL3kyy7YFFYXld8SNWOXsLB0s7fnWx+w/0yyjcTyzhpYClZ5a+nVumR2YTDs5TbzROtg8+lHi60rImhx42reWfl3gdBCLNqZ0vmPGX96a8sM5YK3pHHsP5h9o0fKi6AXdiZjffvjuaZFr6PZ7ZiGLTc50V0gv8fwGoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763353; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPx/hVbtA0rUZmeYOkTkCRXhJPGDFvrMkpIgsDJW6iaBLECT3+jQ32cvDSTrhew8Uw4oJa3mRooMxB8BlCR6u0dpc3GpgEH3IfAIH7gKrEFVAYricvBufLDDRGrLVAW9txc1X0JL7JhLO0QvIwIrv1Q2iIPapIfFdtBem5Y2mUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWM3dtwo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743763351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=iWM3dtwonk0EitxCJf6x16p6LvewTR9E2hmquExKFEJ0bNc1I0THgWg1RAYx/ivqhWal+9
	Eqh4so5bGU3bJhU30NcPsVpU+rE4lOw5iYoC46fonIM+14ajdEVg9q7oEmUdG8DyR/ABb7
	WUnIsc7IKpvHWl/wHwviQmvvDRrA1Lg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-q31lxi-NPr-QPIFQvpDzXg-1; Fri,
 04 Apr 2025 06:42:28 -0400
X-MC-Unique: q31lxi-NPr-QPIFQvpDzXg-1
X-Mimecast-MFC-AGG-ID: q31lxi-NPr-QPIFQvpDzXg_1743763347
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D97419560BB;
	Fri,  4 Apr 2025 10:42:27 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5FDE180B488;
	Fri,  4 Apr 2025 10:42:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Explicitly zero-initialize on-stack CPUID unions
Date: Fri,  4 Apr 2025 06:42:24 -0400
Message-ID: <20250404104224.188290-1-pbonzini@redhat.com>
In-Reply-To: <20250315024102.2361628-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Queued, thanks.

Paolo



