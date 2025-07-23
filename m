Return-Path: <linux-kernel+bounces-741677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF879B0E7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76026C50A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E213C816;
	Wed, 23 Jul 2025 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyqQwFAh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5268472;
	Wed, 23 Jul 2025 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231397; cv=none; b=RX9sjddMG9MJeN3B9sTKR0UHuAzD217HyZ4h+9gPw3Rn2TlQKq/pOMoY91YYtDLUJjCwta7dvsW2uQSvzAPoQDjLzezDc+/yKzsXmSbVhy9lydU+EE8gG9mGV5JCtpOkde+JJd2sgXGoExdRaOBalydLFAwIVMlxqqTNOXtK4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231397; c=relaxed/simple;
	bh=nAEF7ePfhhwZdfBf+TaCKYd86bXhGrrJieY/d3oV8+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwLz6YR3gJSQCF0H93YZUNyasyYoeDHkcd2lRBkPfyWsnznJjDEEaZqUeYo+bvD1m2E1jXx252EwOMQcfdFlC8AeKputYWFELF2+WJOmMaziFF2MRV6Lv2cW9S6D9vSw/iB1uWLEzpyNQUwUXKYiCFCdftVnX6R3ay2OvdlIPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyqQwFAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE2AC4CEEB;
	Wed, 23 Jul 2025 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753231396;
	bh=nAEF7ePfhhwZdfBf+TaCKYd86bXhGrrJieY/d3oV8+4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WyqQwFAhev+zOidJYf7rLOaSA77kabBtJtGQMEIS7VLUof87F0+QLdclsPS11A/NN
	 BwntfrrbmY1pxO0VlBjEY1BDDTUDgV0Ru+lYvkIZ2nwaqQLA/eWerYZ+avcGB5GoF3
	 lkkEwZvhpM/YqEZyA4+Cwb+2pAvIpY3RfWF+ZlkN7XDX09lKXZSYkaweD55uqgZ9Cs
	 YBTPGkO2AtgrXqwsaIweca450Orq2rQEkfnK7LUtlTb3RBZf3FUxI77holwnjohIA4
	 wBewv8V6ReLlVM7YQ5vYWFsl74+8ijYPgMROMhSz8G93n2fUvBf02znjNE54GPYF3c
	 IhfRPg//I31qA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 898D6CE0DEC; Tue, 22 Jul 2025 17:43:16 -0700 (PDT)
Date: Tue, 22 Jul 2025 17:43:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [RFC] tools/memory-model: Rule out OOTA
Message-ID: <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>

On Mon, Jan 06, 2025 at 10:40:03PM +0100, Jonas Oberhauser wrote:
> The current LKMM allows out-of-thin-air (OOTA), as evidenced in the following
> example shared on this list a few years ago:

Apologies for being slow, but I have finally added the litmus tests in
this email thread to the https://github.com/paulmckrcu/litmus repo.

It is quite likely that I have incorrectly intuited the missing portions
of the litmus tests, especially the two called out in the commit log
below.  If you have time, please do double-check.

And the updated (and condensed!) version of the C++ OOTA paper may be
found here, this time with a proposed change to the standard:

https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2025/p3692r1.pdf

							Thanx, Paul

------------------------------------------------------------------------

commit fd17e8fceb75326e159ba3aa6fdb344f74f5c7a5
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jul 22 17:21:19 2025 -0700

    manual/oota:  Add Jonas and Alan OOTA examples
    
    Each of these new litmus tests contains the URL of the email message
    that I took it from.
    
    Please note that I had to tweak the example leading up to
    C-JO-OOTA-4.litmus, and I might well have misinterpreted Jonas's "~"
    operator.
    
    Also, C-JO-OOTA-7.litmus includes a "*r2 = a" statement that makes herd7
    very unhappy.  On the other hand, initializing registers to the address
    of a variable is straight forward, as shown in the resulting litmus test.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/manual/oota/C-AS-OOTA-1.litmus b/manual/oota/C-AS-OOTA-1.litmus
new file mode 100644
index 00000000..81a873a7
--- /dev/null
+++ b/manual/oota/C-AS-OOTA-1.litmus
@@ -0,0 +1,40 @@
+C C-AS-OOTA-1
+
+(*
+ * Result: Sometimes
+ *
+ * Because smp_rmb() combined with smp_wmb() does not order earlier
+ * reads against later writes.
+ *
+ * https://lore.kernel.org/all/a3bf910f-509a-4ad3-a1cc-4b14ef9b3259@rowland.harvard.edu
+ *)
+
+{}
+
+P0(int *a, int *b, int *x, int *y)
+{
+	int r1;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	if (r1 == 1) {
+		*a = *b;
+	}
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y)
+{
+	int r1;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	if (r1 == 1) {
+		*b = *a;
+	}
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+exists (0:r1=1 /\ 1:r1=1)
diff --git a/manual/oota/C-AS-OOTA-2.litmus b/manual/oota/C-AS-OOTA-2.litmus
new file mode 100644
index 00000000..c672b0e7
--- /dev/null
+++ b/manual/oota/C-AS-OOTA-2.litmus
@@ -0,0 +1,33 @@
+C C-AS-OOTA-2
+
+(*
+ * Result: Always
+ *
+ * If we were using C-language relaxed atomics instead of volatiles,
+ * the compiler *could* eliminate the first WRITE_ONCE() in each process,
+ * then also each process's local variable, thus having an undefined value
+ * for each of those local variables.  But this cannot happen given that
+ * we are using Linux-kernel _ONCE() primitives.
+ *
+ * https://lore.kernel.org/all/c2ae9bca-8526-425e-b9b5-135004ad59ad@rowland.harvard.edu/
+ *)
+
+{}
+
+P0(int *a, int *b)
+{
+	int r0 = READ_ONCE(*a);
+
+	WRITE_ONCE(*b, r0);
+	WRITE_ONCE(*b, 2);
+}
+
+P1(int *a, int *b)
+{
+	int r1 = READ_ONCE(*b);
+
+	WRITE_ONCE(*a, r0);
+	WRITE_ONCE(*a, 2);
+}
+
+exists ((0:r0=0 \/ 0:r0=2) /\ (1:r1=0 \/ 1:r1=2))
diff --git a/manual/oota/C-JO-OOTA-1.litmus b/manual/oota/C-JO-OOTA-1.litmus
new file mode 100644
index 00000000..6ab437b4
--- /dev/null
+++ b/manual/oota/C-JO-OOTA-1.litmus
@@ -0,0 +1,40 @@
+C C-JO-OOTA-1
+
+(*
+ * Result: Never
+ *
+ * But Sometimes in LKMM as of early 2025, given that 42 is a possible
+ * value for things like S19..
+ *
+ * https://lore.kernel.org/all/20250106214003.504664-1-jonas.oberhauser@huaweicloud.com/
+ *)
+
+{}
+
+P0(int *a, int *b, int *x, int *y)
+{
+	int r1;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	if (r1 == 1) {
+		*a = *b;
+	}
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y)
+{
+	int r1;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	if (r1 == 1) {
+		*b = *a;
+	}
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+exists (b=42)
diff --git a/manual/oota/C-JO-OOTA-2.litmus b/manual/oota/C-JO-OOTA-2.litmus
new file mode 100644
index 00000000..ad708c60
--- /dev/null
+++ b/manual/oota/C-JO-OOTA-2.litmus
@@ -0,0 +1,44 @@
+C C-JO-OOTA-2
+
+(*
+ * Result: Never
+ *
+ * But Sometimes in LKMM as of early 2025, given that 42 is a possible
+ * value for things like S23.
+ *
+ * https://lore.kernel.org/all/1daba0ea-0dd6-4e67-923e-fd3c1a62b40b@huaweicloud.com/
+ *)
+
+{}
+
+P0(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2 = 0;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	if (r1 == 1) {
+		r2 = *b;
+	}
+	WRITE_ONCE(*a, r2);
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2 = 0;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	if (r1 == 1) {
+		r2 = *a;
+	}
+	WRITE_ONCE(*b, r2);
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+exists (b=42)
diff --git a/manual/oota/C-JO-OOTA-3.litmus b/manual/oota/C-JO-OOTA-3.litmus
new file mode 100644
index 00000000..633b8334
--- /dev/null
+++ b/manual/oota/C-JO-OOTA-3.litmus
@@ -0,0 +1,46 @@
+C C-JO-OOTA-3
+
+(*
+ * Result: Never
+ *
+ * But LKMM finds the all-ones result, perhaps due to not tracking
+ * control dependencies out of the "if" statement.
+ *
+ * https://lore.kernel.org/all/1daba0ea-0dd6-4e67-923e-fd3c1a62b40b@huaweicloud.com/
+ *)
+
+{}
+
+P0(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	r2 = READ_ONCE(*b);
+	if (r1 == 1) {
+		r2 = *b;
+	}
+	WRITE_ONCE(*a, r2);
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	r2 = READ_ONCE(*a);
+	if (r1 == 1) {
+		r2 = *a;
+	}
+	WRITE_ONCE(*b, r2);
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+exists (0:r1=1 /\ 1:r1=1)
diff --git a/manual/oota/C-JO-OOTA-4.litmus b/manual/oota/C-JO-OOTA-4.litmus
new file mode 100644
index 00000000..cab7ebb6
--- /dev/null
+++ b/manual/oota/C-JO-OOTA-4.litmus
@@ -0,0 +1,43 @@
+C C-JO-OOTA-4
+
+(*
+ * Result: Never
+ *
+ * And LKMM agrees, which might be a surprise.
+ *
+ * https://lore.kernel.org/all/1daba0ea-0dd6-4e67-923e-fd3c1a62b40b@huaweicloud.com/
+ *)
+
+{}
+
+P0(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+	int r3;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	r2 = *b;
+	r3 = r1 == 0;
+	WRITE_ONCE(*a, (r3 + 1) & r2);
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+	int r3;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	r2 = *a;
+	r3 = r1 == 0;
+	WRITE_ONCE(*b, (r3 + 1) & r2);
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+exists (0:r1=1 /\ 1:r1=1)
diff --git a/manual/oota/C-JO-OOTA-5.litmus b/manual/oota/C-JO-OOTA-5.litmus
new file mode 100644
index 00000000..145c8378
--- /dev/null
+++ b/manual/oota/C-JO-OOTA-5.litmus
@@ -0,0 +1,44 @@
+C C-JO-OOTA-5
+
+(*
+ * Result: Never
+ *
+ * But LKMM finds the all-ones result, perhaps due r2 being unused.
+ *
+ * https://lore.kernel.org/all/1daba0ea-0dd6-4e67-923e-fd3c1a62b40b@huaweicloud.com/
+ *)
+
+{}
+
+P0(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	if (r1 == 1) {
+		r2 = READ_ONCE(*a);
+	}
+	*b = 1;
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	if (r1 == 1) {
+		r2 = READ_ONCE(*b);
+	}
+	*a = 1;
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+locations [0:r2;1:r2]
+exists (0:r1=1 /\ 1:r1=1)
diff --git a/manual/oota/C-JO-OOTA-6.litmus b/manual/oota/C-JO-OOTA-6.litmus
new file mode 100644
index 00000000..942e6c82
--- /dev/null
+++ b/manual/oota/C-JO-OOTA-6.litmus
@@ -0,0 +1,44 @@
+C C-JO-OOTA-6
+
+(*
+ * Result: Never
+ *
+ * But LKMM finds the all-ones result, due to OOTA on r2.
+ *
+ * https://lore.kernel.org/all/1147ad3e-e3ad-4fa1-9a63-772ba136ea9a@huaweicloud.com/
+ *)
+
+{}
+
+P0(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	if (r1 == 1) {
+		r2 = READ_ONCE(*a);
+	}
+	*b = r2;
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	if (r1 == 1) {
+		r2 = READ_ONCE(*b);
+	}
+	*a = r2;
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+locations [0:r2;1:r2]
+exists (0:r1=1 /\ 1:r1=1)
diff --git a/manual/oota/C-JO-OOTA-7.litmus b/manual/oota/C-JO-OOTA-7.litmus
new file mode 100644
index 00000000..31c0b8ae
--- /dev/null
+++ b/manual/oota/C-JO-OOTA-7.litmus
@@ -0,0 +1,47 @@
+C C-JO-OOTA-7
+
+(*
+ * Result: Never
+ *
+ * But LKMM finds the all-ones result, due to OOTA on r2.
+ *
+ * https://lore.kernel.org/all/1147ad3e-e3ad-4fa1-9a63-772ba136ea9a@huaweicloud.com/
+ *)
+
+{
+	0:r2=a;
+	1:r2=b;
+}
+
+P0(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	if (r1 == 1) {
+		r2 = READ_ONCE(*a);
+	}
+	*r2 = a;
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y)
+{
+	int r1;
+	int r2;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	if (r1 == 1) {
+		r2 = READ_ONCE(*b);
+	}
+	*r2 = b;
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+locations [0:r2;1:r2]
+exists (0:r1=1 /\ 1:r1=1)
diff --git a/manual/oota/C-PM-OOTA-1.litmus b/manual/oota/C-PM-OOTA-1.litmus
new file mode 100644
index 00000000..e771e3c9
--- /dev/null
+++ b/manual/oota/C-PM-OOTA-1.litmus
@@ -0,0 +1,37 @@
+C C-PM-OOTA-1
+
+(*
+ * Result: Never
+ *
+ * LKMM agrees.
+ *
+ * https://lore.kernel.org/all/9a0dccbb-bfa7-4b33-ac1a-daa9841b609a@paulmck-laptop/
+ *)
+
+{}
+
+P0(int *a, int *b, int *x, int *y) {
+	int r1;
+
+	r1 = READ_ONCE(*x);
+	smp_rmb();
+	if (r1 == 1) {
+		WRITE_ONCE(*a, *b);
+	}
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *a, int *b, int *x, int *y) {
+	int r1;
+
+	r1 = READ_ONCE(*y);
+	smp_rmb();
+	if (r1 == 1) {
+		WRITE_ONCE(*b, *a);
+	}
+	smp_wmb();
+	WRITE_ONCE(*x, 1);
+}
+
+exists b=42

